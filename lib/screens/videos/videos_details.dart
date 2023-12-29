import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/videos/videos_model.dart';
import 'package:ommyfitness/providers/shared_preferences/shared_preferences_provider.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/routes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosDetails extends ConsumerStatefulWidget {
  final VideosModelData videosModelData;

  const VideosDetails({super.key, required this.videosModelData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideosDetailsState();
}

String getVideoId(String url) {
  Uri uri = Uri.parse(url);
  String videoId = uri.queryParameters['v'].toString();
  return videoId;
}

class _VideosDetailsState extends ConsumerState<VideosDetails> {
  late YoutubePlayerController _videoController;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  final bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    ref.read(sharedPreferenceInstanceProvider);
    ref.read(isLoggedInProvider);
    ref.read(userNameProvider);
    ref.read(tokenProvider);
    _videoController = YoutubePlayerController(
      initialVideoId: getVideoId(widget.videosModelData.videoUrl.toString()),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_videoController.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _videoController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: isLoggedIn.maybeWhen(
        orElse: () => const SizedBox(),
        data: (data) => data == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      goRouter.goNamed('signIn');
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: redColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Login To Continue",
                          style: TextStyle(
                            color: blackColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _videoController,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      // some widgets
                      player,
                      //some other widgets
                    ],
                  );
                },
              ),
      ),
    );
  }
}
