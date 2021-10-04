import 'package:exfile/shared/cubit/exfile_cubit/exfile_cubit.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XeFileCubit, XeFileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: XeFileCubit.get(context)
              .pages
              .elementAt(XeFileCubit.get(context).currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: XeFileCubit.get(context).currentIndex,
            onTap: (value) {
              XeFileCubit.get(context).changePageNavBar(value);
            },
            items: XeFileCubit.get(context).navBarItem,
          ),
        );
      },
    );
  }
}
