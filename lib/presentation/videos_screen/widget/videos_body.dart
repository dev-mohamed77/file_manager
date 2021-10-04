import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_states.dart';
import 'package:exfile/widget/custom_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideosBody extends StatefulWidget {
  const VideosBody({Key? key}) : super(key: key);

  @override
  State<VideosBody> createState() => _VideosBodyState();
}

class _VideosBodyState extends State<VideosBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoriesCubit.get(context).getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
        builder: (context, state) {
          CategoriesCubit _categoriesCubit = CategoriesCubit.get(context);
          return Visibility(
            visible: _categoriesCubit.videos.isNotEmpty,
            replacement: const Center(child: Text("File Not Found!")),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                var fileVedios = _categoriesCubit.videos[index];
                String path = fileVedios.path;

                return CustomVideos(path: path);
              },
              itemCount: _categoriesCubit.videos.length,
            ),
          );
        },
        listener: (context, state) {});
  }
}
