import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class GallaryImages extends StatelessWidget {
  const GallaryImages({
    Key? key,
    required this.file,
  }) : super(key: key);

  final File? file;

  @override
  Widget build(BuildContext context) {
    if (file == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return InkWell(
      onTap: () {
        OpenFile.open(file!.path);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Image(
            image: ResizeImage(FileImage(file!), width: 150, height: 150),
          )),
    );
  }
}
