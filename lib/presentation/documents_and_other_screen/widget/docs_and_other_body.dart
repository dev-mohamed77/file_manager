import 'dart:io';

import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_states.dart';
import 'package:exfile/widget/file_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

class DocsAndOtherBody extends StatefulWidget {
  const DocsAndOtherBody({Key? key}) : super(key: key);

  @override
  State<DocsAndOtherBody> createState() => _DocsAndOtherBodyState();
}

class _DocsAndOtherBodyState extends State<DocsAndOtherBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoriesCubit.get(context).getDocs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CategoriesCubit _categoriesCubit = CategoriesCubit.get(context);
        return Visibility(
          visible: _categoriesCubit.docs.isNotEmpty,
          replacement: const Center(
            child: Text("File Not Found!"),
          ),
          child: ListView.separated(
            itemBuilder: (context, index) {
              FileSystemEntity docsFile = _categoriesCubit.docs[index];
              String path = docsFile.path;
              File fileItem = File(path);
              return FileItem(
                file: docsFile,
                tap: () {
                  OpenFile.open(docsFile.path);
                },
                fileItem: fileItem, longTap: () {}, checkBoxValue: false,
                path: path,

                // checkBoxValue: false,
                // showCheckBox: false,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: _categoriesCubit.docs.length,
          ),
        );
      },
    );
  }
}
