import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/domain/entities/bookmark_entity.dart';
import '/domain/entities/course_entity.dart';
import '/presentation/widgets/show_certificate.dart';
import '/presentation/providers/riverpod_provider.dart';

class CoursePlayerScreen extends ConsumerWidget {
  const CoursePlayerScreen({super.key, required this.course});
  final CourseEntity course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final YoutubePlayerController playerController = ref.watch(youtubePlayerControllerProvider);
    final List<bool> moduleCompleted = ref.watch(moduleDone);
    final int moduleCurrent = ref.watch(moduleIndex);
    final List<BookmarkEntity> bookmarks = ref.watch(bookmarkProvider);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title, overflow: TextOverflow.ellipsis),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            context.pop();
          }
        ),
      ),
      body: Column(children: [
        YoutubePlayer(
          key: UniqueKey(),
          controller: playerController,
          showVideoProgressIndicator: true,
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
                  onPressed: moduleCurrent == 0 ? null : () {
                    ref.read(moduleIndex.notifier).update((state) => state-1);
                    ref.read(videoIdProvider.notifier).update((state) => course.videosUrl[moduleCurrent]);
                    ref.read(youtubePlayerControllerProvider.notifier).state= 
                    YoutubePlayerController(
                      initialVideoId: course.videosUrl[moduleCurrent],
                      flags: const YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      ),
                    );
                    
                  },
                  child: const Text('Previous',style: TextStyle(color: Colors.white))),
                IconButton(
                  onPressed: () {
                    showAddBookmarks(
                      context: context,
                      size: size, 
                      playerController: playerController,
                      urlVideo: ref.read(videoIdProvider),
                      ref: ref);
                  },
                  icon: const Icon(
                    Icons.bookmark_add_rounded,
                    color: Colors.white,
                  )
                ),
                moduleCurrent == course.modules.length-1 && moduleCompleted.every((completed) => completed == true)  ? 
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    course.percentageCompleted=1;
                    showCertificate(context,isFromCourseScreen: true);
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
                    if( moduleCurrent+1 == course.modules.length ){
                      return;
                    }
                    ref.read(moduleIndex.notifier).update((state) => state+1);
                    ref.read(videoIdProvider.notifier).update((state) => course.videosUrl[moduleCurrent]);
                    ref.read(youtubePlayerControllerProvider.notifier).state= 
                      YoutubePlayerController(
                        initialVideoId: course.videosUrl[moduleCurrent],
                        flags: const YoutubePlayerFlags(
                          autoPlay: false,
                          mute: false,
                        ),
                      );
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
              onPressed: () {
                showBookmarks( 
                  context: context, 
                  size:size, 
                  bookmarks: bookmarks,
                  ref:ref
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.book_rounded),
                  SizedBox(width: 10),
                  Text('Your bookmarks')
                ]
              )
            ),
            Text(  course.modules[moduleCurrent], overflow: TextOverflow.ellipsis,)
          ]
        ),
        Expanded(
          child: ListView.builder(
            itemCount: course.modules.length,
            itemBuilder: (context, index) {
            return ListTile(
              leading: Checkbox(
                value: moduleCompleted[index], 
                onChanged: (value) {
                  ref.read(moduleDone.notifier).update((state) {
                    state[index] = !value!;
                    return state;
                  });
                }
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor
              ),
              title: Text(course.modules[index],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20)
              ),
              onTap: () {
                ref.read(moduleIndex.notifier).update((state) => index);
                ref.read(videoIdProvider.notifier).update((state) => course.videosUrl[index]);
                ref.read(youtubePlayerControllerProvider.notifier).state= 
                  YoutubePlayerController(
                    initialVideoId: course.videosUrl[index],
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false
                    )
                  );
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
  void showAddBookmarks({required BuildContext context, required Size size, required YoutubePlayerController playerController, required String urlVideo, required WidgetRef ref}){
    Duration pos = playerController.value.position;
    TextEditingController title = TextEditingController();
    TextEditingController min = TextEditingController(text: '${pos.inMinutes}:${pos.inSeconds}');
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) =>
        Center(
          child: Align(
            alignment:Alignment.center,
            child: Material(
              color: const Color.fromARGB(0, 0,0,0),
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: Container(
                  height: size.height*0.35,
                  width: size.width*0.8,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        const Text('New bookmark',style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: title,
                          maxLines: 1,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Ajusta este valor para redondear más o menos
                            borderSide: const BorderSide(color: Colors.black), // Color del borde
                          ),
                          
                            hintText: 'Title'),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color:Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                          )),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: min,
                          maxLines: 1,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Ajusta este valor para redondear más o menos
                            borderSide: const BorderSide(color: Colors.black), // Color del borde
                          ),
                          
                            hintText: 'Min.'),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color:Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          )),
                        const SizedBox(height: 20),
                        MaterialButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            BookmarkEntity newBookmark= BookmarkEntity(
                              segunds: pos.inSeconds,
                              title: title.text.isEmpty ? 'no title' : title.text,
                              videoUrl: urlVideo
                            );
                            ref.read(bookmarkProvider.notifier).update((state) => [...state, newBookmark]);
                            FocusScope.of(context).requestFocus(FocusNode());
                            context.pop();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add,color: Colors.white),
                              SizedBox(width: 5),
                              Text('Add',style: TextStyle(color: Colors.white, fontSize: 18)),
                            ],
                          ),
                        )
                      ]
                    )
                  )
                )
              )
            )
          )
        )
      );
  }
  void showBookmarks({required BuildContext context, required Size size, required List<BookmarkEntity> bookmarks, required WidgetRef ref}){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) =>
        Center(
          child: Align(
            alignment:Alignment.center,
            child: Material(
              color: const Color.fromARGB(0, 0,0,0),
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: Container(
                  height: size.height*0.7,
                  width: size.width*0.9,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        const Text('Your bookmarks',style: TextStyle(fontSize: 20),),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: size.height*0.5,
                          child: ListView.builder(
                            itemCount: bookmarks.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(bookmarks[index].title, overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 20)),
                                    const Icon(Icons.play_arrow_rounded),
                                  ]
                                ),
                                onTap: (){
                                  ref.read(youtubePlayerControllerProvider.notifier).state= 
                                  YoutubePlayerController(
                                    initialVideoId: bookmarks[index].videoUrl,
                                    flags: YoutubePlayerFlags(
                                      startAt: bookmarks[index].segunds,
                                      autoPlay: true,
                                      mute: false,
                                    ),
                                  );
                                  context.pop();
                                }
                              );
                            },
                          )
                        ),
                        const SizedBox(height: 20),

                      ]
                    )
                  )
                )
              )
            )
          )
        )
      );
  }
}

