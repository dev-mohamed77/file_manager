import 'dart:io';
import 'package:exfile/shared/utils/size_config.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({Key? key, required this.audio}) : super(key: key);

  final FileSystemEntity? audio;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(ctx: context);
    if (audio == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListTile(
      onTap: () {
        OpenFile.open(audio!.path);
      },
      leading: Container(
        height: SizeConfig.defaultSize! * 4.5,
        width: SizeConfig.defaultSize! * 4.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Colors.deepOrange,
        ),
        child: const Icon(
          Icons.audiotrack_outlined,
          color: ThemeConfig.whiteColor,
        ),
      ),
      title: Text(
        basename(audio!.path),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
