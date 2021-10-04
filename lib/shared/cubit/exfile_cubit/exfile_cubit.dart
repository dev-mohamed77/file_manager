import 'dart:io';
import 'package:exfile/presentation/browse_screen/browse_screen.dart';
import 'package:exfile/presentation/ftb_screen/ftb_screen.dart';
import 'package:exfile/presentation/settings_screen/settings_screen.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_state.dart';
import 'package:exfile/shared/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class XeFileCubit extends Cubit<XeFileStates> {
  XeFileCubit() : super(XeFileInitial());

  static XeFileCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> navBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.folder),
      label: "Browse",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.flip_to_back),
      label: "FTB",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  List<Widget> pages = [
    const BrowseScreen(),
    const FTBScreen(),
    const SettingsScreen(),
  ];

  void changePageNavBar(int page) {
    currentIndex = page;
    emit(XeFileMainNavBar());
  }

  // available Storage
  List<FileSystemEntity> availableStorage = <FileSystemEntity>[];

  checkAvailabelStrorage() async {
    availableStorage.clear();
    List<Directory>? dirList = (await getExternalStorageDirectories());
    availableStorage.addAll(dirList!);
  }

  // get file in storage

  List<String> paths = <String>[];
  List<FileSystemEntity> files = <FileSystemEntity>[];

  getFile(String path) {
    try {
      Directory dir = Directory(path);
      List<FileSystemEntity> dirFiles = dir.listSync();
      files.clear();
      for (FileSystemEntity d in dirFiles) {
        if (!p.basename(d.path).startsWith(".")) {
          // Show hidden files
          files.add(d);
          emit(XeFileGetFile());
        } else {
          files.add(d);
          emit(XeFileGetFile());
        }
      }
    } catch (e) {
      if (e.toString().contains("Permission denied")) {
        CustomDialog.showToast(
            message: "Permission Denied! cannot access this Directory!");
        navigateBack(path);
      }
    }
  }

  navigationBacksubTitle(String path, int index) {
    path = paths[index];
    paths.removeRange(index + 1, paths.length);
    getFile(path);
    emit(XeFileNavigateBackSubTitleState());
  }

  navigateBack(String path) {
    paths.removeLast();
    path = paths.last;
    getFile(path);
    emit(XeFileNavigateBack());
  }

  // on tap Button Directory
  onTapDirectory(String filePath, String path) {
    paths.add(filePath);
    path = filePath;
    getFile(path);
    emit(XeFileOnTapDirectoryState());
  }

  // Open File

  openFile(String filePath) async {
    final openfile = await OpenFile.open(filePath);
    print(openfile.message);
    emit(XeFileOpenFileState());
  }
}
