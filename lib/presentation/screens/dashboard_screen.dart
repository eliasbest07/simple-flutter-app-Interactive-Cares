// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/config/auth/logout_firebase.dart';
import '/domain/entities/course_entity.dart';
import '/presentation/widgets/show_certificate.dart';

import '../providers/riverpod_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(coursesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: IconButton(onPressed: () async{
              await logout();
              context.pushReplacement('/');
            }, icon: const Icon(Icons.exit_to_app_outlined)),
          )
          
        ],
      ),
      body: Column(
        children: [
          const Text('Your courses:',style: TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
              return _CourseTile(courses: courses, index:index); 
              })
            )
          ]
        ),
    );
  }
}

class _CourseTile extends ConsumerWidget {
  const _CourseTile({
    required this.courses, 
    required this.index,
  });

  final List<CourseEntity> courses;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTile(
      title:  Text(courses[index].title, overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 20)),
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Percentage completed'),
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        value: courses[index].percentageCompleted,
                      ),
                    ),
                    Center(
                      child: Text('${(courses[index].percentageCompleted *100).toInt()}%', style: const TextStyle(fontSize: 12),))
                  ],
                ),
              ),
            ]
          ),
          subtitle: courses[index].percentageCompleted == 1 
          ? Row(
            children: [
              MaterialButton(
                color: Theme.of(context).primaryColor,
                onPressed:(){
                  showCertificate(context);
                },
                child:const Text('Certificate', style: TextStyle(color: Colors.white)) 
                ),
              const SizedBox(width: 10),
              MaterialButton(
            color: Theme.of(context).primaryColor,
            onPressed: (){
              ref.read(moduleDone.notifier).state = [];
              ref.read(videoIdProvider.notifier).update((state) => courses[index].videosUrl.first);
              for (var _ in courses[index].modules) {
                ref.read(moduleDone.notifier).update((state) {
                
                  state.add(false);
                  return state;
                });  
              }
              ref.read(bookmarkProvider.notifier).state = courses[index].bookmarks;

              context.push('/dashboard/course', extra: courses[index]);
            },
            child: const Text('Continue', style: TextStyle(color: Colors.white),),
            ),
            ],)
          : MaterialButton(
            color: Theme.of(context).primaryColor,
            onPressed: (){
              ref.read(moduleDone.notifier).state = [];
              ref.read(videoIdProvider.notifier).update((state) => courses[index].videosUrl.first);
              ref.read(youtubePlayerControllerProvider.notifier).state= 
                YoutubePlayerController(
                  initialVideoId: courses[index].videosUrl.first,
                  flags: const YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                );
              for (var _ in courses[index].modules) {
                ref.read(moduleDone.notifier).update((state) { 
                  state.add(false);
                  return state;});  
              }
              ref.read(bookmarkProvider.notifier).state = courses[index].bookmarks;
              context.push('/dashboard/course', extra: courses[index]);
            },
            child: const Text('Continue', style: TextStyle(color: Colors.white),),
            ),
        )]
      );
  }
}
