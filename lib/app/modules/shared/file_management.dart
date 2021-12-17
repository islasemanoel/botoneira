import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class FileManagement {
  Future<bool> deleteFileFromAppDir(String sourceFile);
  Future<String> moveFileToAppDir(String filePathSource, String newName);
}

class FileManagementImpl implements FileManagement {
  @override
  Future<bool> deleteFileFromAppDir(String sourceFile) async {
    try {
      await File(sourceFile).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> moveFileToAppDir(
      String filePathSource, String newFileName) async {
    String appDirectory = await getAppDirectory();

    if (newFileName.contains(appDirectory)) {
      return newFileName;
    }

    String newPath = appDirectory + "/" + newFileName;
    File sourceFile = File(filePathSource);
    File movedFile = await moveFile(sourceFile, newPath);

    return movedFile.path;
  }

  Future<String> getAppDirectory() async {
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory(); //FOR iOS

    return directory!.path;
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      return await sourceFile.rename(newPath);
    } catch (e) {
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }
}
