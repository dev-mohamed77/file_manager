import 'dart:io';

import 'package:exfile/presentation/images_screen/widget/gallary.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_states.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesBody extends StatefulWidget {
  const ImagesBody({Key? key}) : super(key: key);

  @override
  State<ImagesBody> createState() => _ImagesBodyState();
}

class _ImagesBodyState extends State<ImagesBody> {
  @override
  void initState() {
    super.initState();
    CategoriesCubit.get(context).getImages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
        return Visibility(
          visible: categoriesCubit.images!.isNotEmpty,
          replacement: const Text("File Not Found!"),
          child: categoriesCubit.images!.length != null
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    FileSystemEntity f = categoriesCubit.images![index];
                    File file = File(f.path);

                    return GallaryImages(
                      file: file,
                    );
                  },
                  itemCount: categoriesCubit.images!.length,
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: ThemeConfig.primaryColor,
                )),
        );
      },
    );
  }
}
