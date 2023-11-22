import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerControllerNotifier
    extends StateNotifier<YoutubePlayerController> {
  YoutubePlayerControllerNotifier(String videoId)
      : super(YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        ));
}
