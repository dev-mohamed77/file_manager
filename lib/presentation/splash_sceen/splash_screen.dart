import 'package:exfile/presentation/splash_sceen/widget/splash_body.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ThemeConfig.primaryColor,
      body: SplashBody(),
    );
  }
}
