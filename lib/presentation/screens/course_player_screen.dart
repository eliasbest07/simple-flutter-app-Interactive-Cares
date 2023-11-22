import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/entities/course_entity.dart';
import '/presentation/providers/riverpod_provider.dart';

class CoursePlayerScreen extends ConsumerWidget {
  const CoursePlayerScreen({super.key, required this.course});
  final CourseEntity course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerController = ref.watch(youtubePlayerControllerProvider);
    final moduleCompleted = ref.watch(moduleDone);
    final moduleCurrent = ref.watch(moduleIndex);
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title, overflow: TextOverflow.ellipsis),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            onPressed: () {
              context.pop();
            }),
      ),
      body: Column(children: [
        Consumer(
          builder: (context, ref, child) {
            return YoutubePlayer(
            controller: playerController,
            showVideoProgressIndicator: true,
          );
          },
          
        ),
        Container(
          width: double.infinity,
          height: 70,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  color: const Color.fromARGB(255, 124, 124, 124),
                  onPressed: moduleCurrent == 0 ? null: () {
                    ref.read(moduleIndex.notifier).update((state) => state-1);
                    ref.read(videoIdProvider.notifier).update((state) => course.videosUrl[moduleCurrent]);
                  },
                  child: const Text('Previous',style: TextStyle(color: Colors.white))),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_add_rounded,
                    color: Colors.white,
                  )
                ),
                moduleCurrent == course.modules.length-1 ? 
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    context.push('/dashborad');
                  },
                  child:const Text('Certificate',style: TextStyle(color:Colors.white)),
                )
                : MaterialButton(
                  color: const Color.fromARGB(255, 124, 124, 124),
                  onPressed: () {
                    ref.read(moduleDone.notifier).update((state) {
                      state[moduleCurrent]=true;
                      return state;
                    }); 
                    ref.read(moduleIndex.notifier).update((state) => state+1);
                    ref.read(videoIdProvider.notifier).update((state) => course.videosUrl[moduleCurrent]);

                    
                  },
                  child: const Text('Next',style: TextStyle(color: Colors.white))
                )
              ]
            )
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              color: Theme.of(context).secondaryHeaderColor,
              onPressed: () {},
              child: const Row(children: [
                Icon(Icons.book_rounded),
                SizedBox(width: 10),
                Text('Your bookmarks')
              ])
            ),
            Text(course.modules[moduleCurrent], overflow: TextOverflow.ellipsis,)
          ]
        ),
        Expanded(
          child: ListView.builder(
            itemCount: course.modules.length,
            itemBuilder: (context, index) {
            return ListTile(
              leading: Checkbox(value: moduleCompleted[index], onChanged: (value) {
                ref.read(moduleDone.notifier).update((state) {
                  state[index]=value!;
                  return state;
                });
              }),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(course.modules[index],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20)),
              onTap: () {
                ref.read(moduleIndex.notifier).update((state) => index);
                ref.read(videoIdProvider.notifier).update((state) => course.videosUrl[index]);
                ref.read(moduleDone.notifier).update((state) {
                  state[index]=true;
                  return state;
                });
              }
            );
          })
        )
      ])
    );
  }
}
