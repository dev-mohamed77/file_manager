import 'dart:io';
import 'package:exfile/presentation/app_screen/app_screen.dart';
import 'package:exfile/presentation/audio_screen/audio_screen.dart';
import 'package:exfile/presentation/documents_and_other_screen/docs_and_other_screen.dart';
import 'package:exfile/presentation/download_screen/download_screen.dart';
import 'package:exfile/presentation/images_screen/images_screen.dart';
import 'package:exfile/presentation/videos_screen/videos_screen.dart';
import 'package:exfile/presentation/whatsapp_screen/whatsapp_screen.dart';
import 'package:exfile/shared/utils/constant.dart';
import 'package:exfile/shared/utils/dialog.dart';
import 'package:exfile/shared/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'categories_section_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Map category = Constant.categories[index];
        return CategoriesSectionItems(
          icon: category["icon"],
          color: category["color"],
          title: category["title"],
          tap: () => _onClick(index, context),
        );
      },
      separatorBuilder: (context, index) {
        return Column(
          children: const [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 60, end: 20),
              child: Divider(
                thickness: 1,
                height: 3,
              ),
            ),
          ],
        );
      },
      itemCount: Constant.categories.length,
    );
  }

  _onClick(int index, BuildContext context) async {
    if (index == Constant.categories.length - 1) {
      // check whatsapp installed
      if (Directory(Constant.whatsAppPath).existsSync()) {
        Navigate.push(ctx: context, screen: const WhatsAppScreen());
      } else {
        CustomDialog.showToast(
            message: "Please Install WhatsApp to use this feature");
      }
    }
    if (index == 0) {
      Navigate.push(
          ctx: context,
          screen: DownLoadScreen(title: "${Constant.categories[0]["title"]}"));
    } else if (index == 1) {
      final request = await PhotoManager.requestPermission();
      if (request) {
        Navigate.push(ctx: context, screen: const ImagesScreen());
      } else {
        CustomDialog.showToast(message: "Please Grant Storage Permissions");
        PhotoManager.openSetting();
      }
    } else if (index == 2) {
      final request = await PhotoManager.requestPermission();
      if (request) {
        Navigate.push(ctx: context, screen: const VideosScreen());
      } else {
        CustomDialog.showToast(message: "Please Grant Storage Permissions");
        PhotoManager.openSetting();
      }
    } else if (index == 3) {
      Navigate.push(ctx: context, screen: const AudioScreen());
    } else if (index == 4) {
      Navigate.push(ctx: context, screen: const DocsAndOtherScreen());
    } else if (index == 5) {
      Navigate.push(ctx: context, screen: const AppScreen());
    }
  }
}
