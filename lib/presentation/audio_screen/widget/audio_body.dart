import 'dart:io';

import 'package:exfile/presentation/audio_screen/widget/audio_item.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_states.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioBody extends StatefulWidget {
  const AudioBody({Key? key}) : super(key: key);

  @override
  State<AudioBody> createState() => _AudioBodyState();
}

class _AudioBodyState extends State<AudioBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoriesCubit.get(context).getAudios();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
        builder: (context, state) {
          CategoriesCubit _categoriesCubit = CategoriesCubit.get(context);
          return Visibility(
            replacement: const Center(child: Text("File Not Found!")),
            visible: _categoriesCubit.audios!.isNotEmpty,
            child: _categoriesCubit.audios != null
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      FileSystemEntity fileAudio =
                          _categoriesCubit.audios![index];

                      return AudioItem(
                        audio: fileAudio,
                      );
                    },
                    itemCount: _categoriesCubit.audios!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: ThemeConfig.primaryColor,
                    ),
                  ),
          );
        },
        listener: (context, state) {});
  }
}
