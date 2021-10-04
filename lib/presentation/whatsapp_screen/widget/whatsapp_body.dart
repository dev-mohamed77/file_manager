import 'dart:io';

import 'package:exfile/presentation/whatsapp_screen/widget/whats_item.dart';
import 'package:exfile/shared/utils/constant.dart';
import 'package:exfile/shared/utils/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

class WhatsAppBody extends StatelessWidget {
  WhatsAppBody({Key? key}) : super(key: key);

  final List<FileSystemEntity> files = Directory(Constant.whatsAppPath)
      .listSync()
    ..removeWhere((file) => basename(file.path).split("")[0] == ".");

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemBuilder: (context, index) {
          FileSystemEntity file = files[index];
          String path = file.path;
          File fileItem = File(path);
          String? mimeType = mime(path);
          return WhatsAppItem(
            file: file,
            itemFile: fileItem,
            mimeType: mimeType,
            path: path,
            onClickSave: () async {
              String rootPath = '/storage/emulated/0/';
              // create folder
              await Directory("${rootPath}ExFile").create();
              // create folder inside folder ExFile
              await Directory("${rootPath}ExFile/WhatsApp Status").create();
              // The Status Copy inside Folder WhatsApp Status
              await fileItem
                  .copy("${rootPath}ExFile/WhatsApp Status/${basename(path)}");
              // Show Toast
              CustomDialog.showToast(message: "Saved!");
            },
          );
        });
  }
}
