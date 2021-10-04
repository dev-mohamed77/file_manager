import 'package:exfile/presentation/folder_screen/folder_screen.dart';
import 'package:exfile/shared/utils/navigate.dart';
import 'package:exfile/shared/utils/size_config.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SectionStorageItem extends StatelessWidget {
  final double parcent;
  final IconData icon;
  final String storageName;
  final Color iconColor;
  final int usedStorage;
  final int totalStoarge;

  final String path;

  const SectionStorageItem({
    Key? key,
    required this.parcent,
    required this.icon,
    required this.path,
    required this.storageName,
    required this.iconColor,
    required this.usedStorage,
    required this.totalStoarge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigate.push(
            ctx: context, screen: FolderScreen(title: storageName, path: path));
      },
      child: SizedBox(
        height: 10,
        width: SizeConfig.defaultSize! * 20,
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  storageName,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 16),
                ),
                const Spacer(),
                Row(
                  children: [
                    textStoragesize(
                      context: context,
                      text: "${usedStorage}GB Used",
                    ),
                    const Spacer(),
                    textStoragesize(
                      context: context,
                      text: "${totalStoarge}GB Free",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                LinearPercentIndicator(
                  percent: parcent,
                  linearGradient: LinearGradient(
                    colors: [
                      ThemeConfig.primaryColor,
                      const Color(0xff222F53).withOpacity(0.4),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text textStoragesize({required BuildContext context, required String text}) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontSize: 10,
          ),
    );
  }
}
