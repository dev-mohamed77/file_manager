import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomDialog {
  static void showBuildDialog({
    required BuildContext ctx,
    required String title,
    required String contentText,
    bool isShowAction = false,
  }) {
    showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: ThemeConfig.greyColor,
          title: Text(title),
          content: Text(contentText),

          // actions: [
          //   ElevatedButton(
          //     onPressed: () {},
          //     child: Text(),
          //   )
          // ],
        );
      },
    );
  }

  static void showToast({required String message}) {
    Fluttertoast.showToast(msg: message);
  }
}
