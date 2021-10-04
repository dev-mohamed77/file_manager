import 'dart:io';

import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_cubit.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

class FileItem extends StatefulWidget {
  FileItem({
    Key? key,
    required this.file,
    required this.tap,
    required this.fileItem,
    required this.checkBoxValue,
    this.longTap,
    this.showCheckBox = false,
    required this.path,
  }) : super(key: key);

  final FileSystemEntity file;
  final File fileItem;
  final void Function()? tap;
  final void Function()? longTap;
  final bool showCheckBox;
  late bool checkBoxValue;
  final String path;

  @override
  State<FileItem> createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
  List menuItemList = ["Copy", "Share", "Delete"];
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: widget.longTap,
      onTap: widget.tap,
      trailing: CategoriesCubit.get(context).showCheckBox
          ? Checkbox(
              onChanged: (value) {
                setState(() {
                  widget.checkBoxValue = !widget.checkBoxValue;
                });
              },
              value: widget.checkBoxValue,
            )
          : PopupMenuButton(
              itemBuilder: (context) {
                return menuItemList.map((item) {
                  return PopupMenuItem(
                    child: Text(item),
                    value: item,
                    onTap: () async {
                      if (item == "Copy") {
                        print("copy");
                        // widget.fileItem.copy()
                      } else if (item == "Share") {
                        print("Share");
                      } else if (item == "Delete") {
                        print("Delete");
                        await widget.fileItem.delete(recursive: true);
                        XeFileCubit.get(context).navigateBack(widget.path);
                        CategoriesCubit.get(context).getDownLoad();
                      }
                    },
                  );
                }).toList();
              },
            ),
      leading:
          widget.file.path.endsWith(".jpg") || widget.file.path.endsWith(".png")
              ? Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Image(
                      fit: BoxFit.cover,
                      image: ResizeImage(FileImage(widget.fileItem),
                          width: 100, height: 100)),
                )
              : Icon(
                  icon(widget.file.path),
                  color: Colors.deepOrange,
                  size: 30,
                ),
      title: Text(
        basename(widget.file.path),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

IconData icon(String path) {
  IconData fileIcon = FontAwesomeIcons.file;
  if (path.endsWith(".mp4") ||
      path.endsWith(".mpeg") ||
      path.endsWith(".avi") ||
      path.endsWith(".mkv") ||
      path.endsWith(".webm") ||
      path.endsWith(".3gp") ||
      path.endsWith(".wmv") ||
      path.endsWith(".flv") ||
      path.endsWith(".mov")) {
    fileIcon = FontAwesomeIcons.video;
  } else if (path.endsWith(".mp3")) {
    fileIcon = FontAwesomeIcons.music;
  } else if (path.endsWith(".pdf") ||
      path.endsWith(".pdf") ||
      path.endsWith(".epub") ||
      path.endsWith(".doc") ||
      path.endsWith(".mobi")) {
    return FontAwesomeIcons.filePdf;
  }
  return fileIcon;
}
