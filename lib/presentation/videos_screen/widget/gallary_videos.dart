import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class GallaryVideos extends StatelessWidget {
  const GallaryVideos(
      {Key? key,
      required this.file,
      required this.fileVideos,
      required this.path})
      : super(key: key);
  final FileSystemEntity file;
  final String path;
  final File fileVideos;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        OpenFile.open(file.path);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.video_call_outlined),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: Image(
              image:
                  ResizeImage(FileImage(fileVideos), width: 100, height: 100),
            ),
          ),
        ],
      ),
    );
  }
}
