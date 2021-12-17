import 'dart:io';
import 'package:file_picker/file_picker.dart';

abstract class PickAudioFile {
  Future<String?> call();
}

class PickAudioFileImpl implements PickAudioFile {

  Future<String?> call() async {
    FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
    );

    if (result != null || result!.files.length > 0) {
      File file = File(result.files.single.path!);    
      return file.path;
    } else {
      return null;
    }
  }
}
