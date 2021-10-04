import 'dart:io';

import 'package:exfile/shared/utils/file_utils.dart';
import 'package:exfile/widget/custom_video.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhatsAppItem extends StatelessWidget {
  const WhatsAppItem(
      {Key? key,
      required this.file,
      required this.itemFile,
      required this.path,
      required this.mimeType,
      required this.onClickSave})
      : super(key: key);

  final FileSystemEntity file;
  final String path;
  final File itemFile;
  final String? mimeType;
  final void Function()? onClickSave;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black54, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onClickSave,
              icon: const Icon(FontAwesomeIcons.save),
            ),
            Text(
              FileUtils.formatBytes(itemFile.lengthSync(), 1),
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      child: path.endsWith(".mp4") ||
              path.endsWith(".mpeg") ||
              path.endsWith(".avi") ||
              path.endsWith(".mkv") ||
              path.endsWith(".webm") ||
              path.endsWith(".3gp") ||
              path.endsWith(".wmv") ||
              path.endsWith(".flv")
          ? CustomVideos(path: path)
          : Image(
              fit: BoxFit.cover,
              errorBuilder: (context, object, s) {
                return const Icon(Icons.image);
              },
              image: ResizeImage(
                FileImage(itemFile),
                width: 150,
                height: 150,
              ),
            ),
    );
  }
}
