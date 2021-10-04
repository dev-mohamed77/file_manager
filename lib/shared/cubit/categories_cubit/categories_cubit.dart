import 'dart:io';

import 'package:exfile/shared/utils/dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CatesgoriesInitialStates());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  // select File by CheckBox

  bool showCheckBox = false;

  changeShowCheckBox() {
    showCheckBox = !showCheckBox;
    emit(CatesgoriesChangeShowCheckBoxStates());
  }

  // get files in device

  Future<List<Directory>> getFilesInDevice() async {
    List<Directory>? storage = await getExternalStorageDirectories();
    List<Directory> filterPath = [];
    for (Directory s in storage!) {
      String path = s.path.split("Android")[0];
      filterPath.add(Directory(path));
    }
    return filterPath;
  }

  // Get all files in download
  //FileSystemEntity

  List<Map<String, dynamic>> downloads = [];

  getDownLoad() async {
    emit(CatesgoriesLoadingGetDownloadStates());
    downloads.clear();
    List<Directory> paths = await getFilesInDevice();

    paths.forEach((dir) {
      // Check if the download folder exists or not
      if (Directory(dir.path + "Download").existsSync()) {
        // Store all files inside the download folder in a files variable
        List<FileSystemEntity> files =
            Directory(dir.path + "Download").listSync();

        files.forEach((file) {
          // To verify that only files and not folders are added to the downloads list
          if (FileSystemEntity.isFileSync(file.path)) {
            downloads.add({"File": file, "SelectedFile": false});
          }
        });
      }
    });
    print("Download = $downloads");
    emit(CatesgoriesSuccessGetDownloadStates());
  }

  // get Images and videos by Photo Manager

  List<FileSystemEntity>? images = [];

  getImages() async {
    emit(CatesgoriesLoadingGetVideosStates());
    images!.clear();
    List<Directory> storage = await getFilesInDevice();

    storage.forEach((dir) {
      List<FileSystemEntity> _files =
          dir.listSync(recursive: true, followLinks: false);

      for (FileSystemEntity file in _files) {
        String path = file.path;
        if (path.endsWith(".png") || path.endsWith(".jpg")) {
          images!.add(file);
        }
      }
    });
    emit(CatesgoriesSuccessGetVideosStates());
  }

  // getImages() async {
  //   images.clear();
  //   final albume = await PhotoManager.getAssetPathList();
  //   final recentAlbume = albume.first;
  //   final recentfiles =
  //       await recentAlbume.getAssetListRange(start: 0, end: 10000000);

  //   images = recentfiles;
  //   print("images = $images");
  //   emit(CatesgoriesSuccessGetImagesStates());
  // }

  // Get Videos

  List<FileSystemEntity> videos = [];

  getVideos() async {
    emit(CatesgoriesLoadingGetVideosStates());
    videos.clear();
    List<Directory> storage = await getFilesInDevice();

    storage.forEach((dir) {
      List<FileSystemEntity> _files =
          dir.listSync(recursive: true, followLinks: false);

      for (FileSystemEntity file in _files) {
        String path = file.path;
        if (path.endsWith(".mp4") ||
            path.endsWith(".mpeg") ||
            path.endsWith(".avi") ||
            path.endsWith(".mkv") ||
            path.endsWith(".webm") ||
            path.endsWith(".3gp") ||
            path.endsWith(".wmv") ||
            path.endsWith(".flv") ||
            path.endsWith(".mov")) {
          videos.add(file);
        }
      }
    });
    emit(CatesgoriesSuccessGetVideosStates());
  }

  // Get Audios

  List<FileSystemEntity>? audios = [];

  getAudios() async {
    emit(CatesgoriesLoadingGetAudiosStates());
    audios!.clear();
    List<Directory> storage = await getFilesInDevice();
    storage.forEach((dir) {
      List<FileSystemEntity> files =
          dir.listSync(recursive: true, followLinks: false);

      for (FileSystemEntity file in files) {
        String path = file.path;
        if (path.endsWith(".mp3")) {
          audios!.add(file);
        }
      }
    });

    emit(CatesgoriesLoadingGetAudiosStates());
  }

  // get documents

  List<FileSystemEntity> docs = [];

  getDocs() async {
    emit(CatesgoriesLoadingGetDocsStates());
    docs.clear();
    List<Directory> storage = await getFilesInDevice();
    storage.forEach((file) {
      List<FileSystemEntity> docsFile =
          file.listSync(recursive: true, followLinks: false);
      for (FileSystemEntity doc in docsFile) {
        String path = doc.path;
        if (path.endsWith(".pdf")) {
          docs.add(doc);
        }
      }
    });
    print("Docs = $docs");
    emit(CatesgoriesSuccessGetDocsStates());
  }

  // delete File

  deleteFile(File file, selectedFile) async {
    try {
      if (selectedFile) {
        getDownLoad();
        print("here");
        await file.delete(recursive: true);
        CustomDialog.showToast(message: "Delete Successful");
        getDownLoad();
        print("Delete Downloads = $downloads");
      }
    } catch (e) {
      print("hereeeeee");
      print(e);
      if (e.toString().contains("Permission denied")) {
        CustomDialog.showToast(message: "Cannot write to this Storage device!");
      }
    }
    emit(CatesgoriesDeleteFileStates());
  }
}
