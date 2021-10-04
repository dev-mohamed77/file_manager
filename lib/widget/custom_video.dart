import 'dart:io';

import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:video_player/video_player.dart';

class CustomVideos extends StatefulWidget {
  const CustomVideos({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<CustomVideos> createState() => _CustomVideosState();
}

class _CustomVideosState extends State<CustomVideos>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((value) {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      }).catchError((error) {
        print(error);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? Image.asset(
            "assets/images/video-placeholder.png",
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          )
        : InkWell(
            onTap: () {
              OpenFile.open(widget.path);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_controller),
                const Icon(
                  FontAwesomeIcons.playCircle,
                  color: ThemeConfig.whiteColor,
                  size: 30,
                )
              ],
            ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
