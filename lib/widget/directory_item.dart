import 'dart:io';

import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

class DirectoryItem extends StatelessWidget {
  const DirectoryItem({Key? key, required this.file, required this.tap})
      : super(key: key);
  final FileSystemEntity file;
  final void Function()? tap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
        color: ThemeConfig.primaryColor,
      ),
      leading: Container(
        height: 35,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
        ),
        child: const Center(
          child: Icon(
            FontAwesomeIcons.solidFolderOpen,
            size: 22,
            color: Colors.white,
          ),
        ),
      ),
      title: Text("${basename(file.path)}"),
    );
  }
}
