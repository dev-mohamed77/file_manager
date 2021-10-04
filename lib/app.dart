import 'package:exfile/presentation/splash_sceen/splash_screen.dart';
import 'package:exfile/shared/cubit/categories_cubit/categories_cubit.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_cubit.dart';
import 'package:exfile/shared/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExFileApp extends StatelessWidget {
  const ExFileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<XeFileCubit>(
          create: (context) => XeFileCubit(),
        ),
        BlocProvider<CategoriesCubit>(
            create: (context) => CategoriesCubit()..getDownLoad()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: ThemeConfig.primaryColorLight,
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            iconTheme: const IconThemeData(
              color: ThemeConfig.blackColor,
            ),
            titleTextStyle: const TextStyle(
              fontFamily: "Quicksand",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ThemeConfig.blackColor,
            ),
            elevation: 0,
          ),
          fontFamily: "Quicksand",
          textTheme: const TextTheme(
            subtitle1: TextStyle(
              color: ThemeConfig.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
