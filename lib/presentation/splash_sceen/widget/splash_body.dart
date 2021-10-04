import 'dart:async';

import 'package:exfile/layout/main_layout.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_cubit.dart';
import 'package:exfile/shared/utils/dialog.dart';
import 'package:exfile/shared/utils/navigate.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadeInAnimation;

  startTime() {
    return Timer(const Duration(seconds: 3), () {
      handelTimeout();
    });
  }

  void handelTimeout() {
    requestPermissin();
  }

  changeScreen() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    if (!permissionStatus.isGranted) {
      requestPermissin();
    } else {
      Navigate.pushReplace(ctx: context, screen: const MainLayout());
    }
  }

  requestPermissin() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
      Navigate.pushReplace(ctx: context, screen: const MainLayout());
    } else {
      CustomDialog.showToast(message: "Please Grant Storage Permissions");
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    fadeInAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);
    startTime();
    XeFileCubit.get(context).checkAvailabelStrorage();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.folder,
            color: ThemeConfig.whiteColor,
            size: 100,
          ),
          FadeTransition(
            opacity: fadeInAnimation!,
            child: const Text(
              "XeFile",
              style: TextStyle(
                color: ThemeConfig.whiteColor,
                fontFamily: "Quicksand",
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
