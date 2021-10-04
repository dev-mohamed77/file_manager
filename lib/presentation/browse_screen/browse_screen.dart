import 'package:exfile/presentation/browse_screen/widget/categories_section.dart';
import 'package:exfile/widget/custom_appbar.dart';
import 'package:exfile/presentation/browse_screen/widget/recent_section.dart';
import 'package:exfile/presentation/browse_screen/widget/section_text.dart';
import 'package:exfile/presentation/browse_screen/widget/storege_section.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_cubit.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_state.dart';
import 'package:exfile/shared/utils/size_config.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(ctx: context);
    return BlocConsumer<XeFileCubit, XeFileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeConfig.primaryColorLight,
          appBar: CustomAppBar(
            alignment: const Alignment(0, 0.5),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: SizeConfig.defaultSize! * 4.3,
                width: SizeConfig.defaultSize! * 37,
                decoration: BoxDecoration(
                  color: ThemeConfig.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 7,
                    ),
                    Icon(
                      Icons.search,
                      size: SizeConfig.defaultSize! * 3.6,
                      color: ThemeConfig.primaryColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Search",
                      style: TextStyle(
                        color: ThemeConfig.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            height: SizeConfig.defaultSize! * 10,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: RefreshIndicator(
              color: ThemeConfig.primaryColor,
              onRefresh: () =>
                  XeFileCubit.get(context).checkAvailabelStrorage(),
              child: ListView(
                children: [
                  const SectionText(text: "Storege"),
                  const SizedBox(height: 5),
                  StoregeSection(
                    xeFileCubit: XeFileCubit.get(context),
                  ),
                  const SizedBox(height: 15),
                  const SectionText(text: "Categories"),
                  const SizedBox(height: 10),
                  const CategoriesSection(),
                  const SizedBox(height: 15),
                  const SectionText(text: "Recent"),
                  const RecentSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
