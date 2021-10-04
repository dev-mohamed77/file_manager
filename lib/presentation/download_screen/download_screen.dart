import 'dart:io';

import 'package:exfile/presentation/download_screen/widget/download_body.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_states.dart';
import 'package:exfile/shared/utils/dialog.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:exfile/widget/file_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';

class DownLoadScreen extends StatelessWidget {
  DownLoadScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeConfig.primaryColorLight,
            title: Text(title),
            leading: !categoriesCubit.showCheckBox
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      categoriesCubit.showCheckBox = false;
                    },
                  )
                : InkWell(
                    onTap: () {
                      categoriesCubit.changeShowCheckBox();
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeConfig.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
          body: DownloadBody(categoriesCubit: categoriesCubit),
          bottomNavigationBar: categoriesCubit.showCheckBox
              ? Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SelectedItem(
                        onTap: () {},
                        nameSelector: "Copy",
                        icon: FontAwesomeIcons.copy,
                      ),
                      SelectedItem(
                        onTap: () {},
                        nameSelector: "Move",
                        icon: Icons.move_to_inbox_outlined,
                      ),
                      SelectedItem(
                        onTap: () async {
                          // categoriesCubit.deleteFile(fileItem, selectedFile);
                        },
                        nameSelector: "Delete",
                        icon: Icons.delete_outline,
                      ),
                    ],
                  ),
                )
              : Container(
                  color: ThemeConfig.primaryColorLight,
                  height: 1,
                ),
        );
      },
    );
  }
}

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    Key? key,
    required this.onTap,
    required this.nameSelector,
    required this.icon,
  }) : super(key: key);

  final void Function()? onTap;
  final String nameSelector;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: ThemeConfig.primaryColor,
              size: 20,
            ),
            Text(
              nameSelector,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
