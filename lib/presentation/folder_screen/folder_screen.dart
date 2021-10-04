import 'dart:io';

import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/widget/directory_item.dart';
import 'package:exfile/widget/file_item.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_cubit.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_state.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:exfile/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({Key? key, required this.title, required this.path})
      : super(key: key);
  final String title;
  final String path;

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen>
    with WidgetsBindingObserver {
  late String path;

  @override
  void initState() {
    super.initState();
    path = widget.path;
    XeFileCubit.get(context).getFile(path);
    XeFileCubit.get(context).paths.add(widget.path);

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XeFileCubit, XeFileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var xeFileCubit = XeFileCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () {
                if (xeFileCubit.paths.length <= 1) {
                  Navigator.pop(context);
                  xeFileCubit.paths.clear();
                } else {
                  xeFileCubit.navigateBack(path);
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: ThemeConfig.primaryColor,
              ),
            ),
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 15,
                  ),
            ),
            bottom: CustomAppBar(
              height: 35,
              color: ThemeConfig.primaryColor,
              alignment: Alignment.centerLeft,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  String p = xeFileCubit.paths[index];

                  List<String> pathSplit = p.split("/");

                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        xeFileCubit.navigationBacksubTitle(path, index);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            widget.title == "Internal Storage"
                                ? "Internal Storage"
                                : "SD Card",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: xeFileCubit.paths.length - 1 == index
                                  ? Colors.amber
                                  : ThemeConfig.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      xeFileCubit.navigationBacksubTitle(path, index);
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "${pathSplit[pathSplit.length - 1]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: xeFileCubit.paths.length - 1 == index
                                ? Colors.amber
                                : ThemeConfig.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Icon(
                    Icons.arrow_forward_ios,
                    color: ThemeConfig.primaryColor,
                    size: 15,
                  );
                },
                itemCount: xeFileCubit.paths.length,
              ),
            ),
          ),
          body: Visibility(
            replacement: const Center(
              child: Text("There is nothing here"),
            ),
            visible: xeFileCubit.files.isNotEmpty,
            child: ListView.separated(
              itemBuilder: (contsext, index) {
                FileSystemEntity file = xeFileCubit.files[index];
                File fileItem = File(file.path);

                if (file.toString().split(":")[0] == "Directory") {
                  return DirectoryItem(
                    file: file,
                    tap: () {
                      xeFileCubit.onTapDirectory(file.path, path);
                    },
                  );
                }
                return FileItem(
                  file: file,
                  tap: () {
                    xeFileCubit.openFile(file.path);
                  },
                  fileItem: fileItem, longTap: () {},

                  checkBoxValue: false, path: path,
                  // checkBoxValue: false,
                  // showCheckBox: false,
                );
              },
              separatorBuilder: (contsext, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: xeFileCubit.files.length,
            ),
          ),
        );
      },
    );
  }
}
