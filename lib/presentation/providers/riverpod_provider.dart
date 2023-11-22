import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/domain/entities/course_entity.dart';
import '/presentation/providers/course_notifier.dart';
import '/presentation/providers/youtube_player_controller_notifier.dart';

final moduleDone = StateProvider<List<bool>>((ref) => []);

final moduleIndex = StateProvider<int>((ref) => 0);

final videoIdProvider = StateProvider<String>((ref) => '');

final coursesProvider = StateNotifierProvider<CourseNotifier, List<CourseEntity>>((ref) {
  return CourseNotifier();
});

final youtubePlayerControllerProvider = StateNotifierProvider<YoutubePlayerControllerNotifier, YoutubePlayerController>((ref) {
  return YoutubePlayerControllerNotifier(ref.watch(videoIdProvider));
});
