import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/domain/entities/bookmark_entity.dart';
import '/domain/entities/course_entity.dart';
import '/presentation/providers/course_notifier.dart';

final moduleDone = StateProvider<List<bool>>((ref) => []);

final moduleIndex = StateProvider<int>((ref) => 0);

final videoIdProvider = StateProvider<String>((ref) => '');

final bookmarkProvider = StateProvider<List<BookmarkEntity>>((ref) => []);

final coursesProvider = StateNotifierProvider<CourseNotifier, List<CourseEntity>>((ref) {
  return CourseNotifier();
});

final youtubePlayerControllerProvider = StateProvider< YoutubePlayerController>((ref) {
  return YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
});


AnimationController loginAnimation = useAnimationController(duration: const Duration(milliseconds: 1000));

AnimationController registerAnimation = useAnimationController(duration: const Duration(milliseconds: 1000));

final loginEmail = StateNotifierProvider<TextController, TextEditingController>((ref) {
  return TextController();
});

final registerEmail = StateNotifierProvider<TextController, TextEditingController>((ref) {
  return TextController();
});

final loginPassword = StateNotifierProvider<TextController, TextEditingController>((ref) {
  return TextController();
});

final registerPassword = StateNotifierProvider<TextController, TextEditingController>((ref) {
  return TextController();
});

final hiddenPassword = StateProvider<bool>((ref) => true);
class TextController extends StateNotifier<TextEditingController> {
  TextController() : super(TextEditingController());

  String getState() {
    return state.text;
  }
}