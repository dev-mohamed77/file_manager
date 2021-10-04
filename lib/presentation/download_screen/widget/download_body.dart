import 'dart:io';
import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/widget/file_item.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class DownloadBody extends StatelessWidget {
  const DownloadBody({Key? key, required this.categoriesCubit})
      : super(key: key);
  final CategoriesCubit categoriesCubit;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: const Center(child: Text("No Files Found!")),
      visible: categoriesCubit.downloads.isNotEmpty,
      child: ListView.separated(
        itemBuilder: (context, index) {
          FileSystemEntity download = categoriesCubit.downloads[index]["File"];
          bool selectedFile = categoriesCubit.downloads[index]["SelectedFile"];
          String path = download.path;
          File fileItem = File(path);
          return FileItem(
            file: download,
            tap: () {
              OpenFile.open(path);
            },
            fileItem: fileItem,
            showCheckBox: categoriesCubit.showCheckBox,
            longTap: () {
              categoriesCubit.changeShowCheckBox();
            },
            checkBoxValue: selectedFile,
            path: path,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 5,
          );
        },
        itemCount: CategoriesCubit.get(context).downloads.length,
      ),
    );
  }
}
