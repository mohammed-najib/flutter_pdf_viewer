import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';

class PDFApi {
  static Future<File?> pickFile() async {
    final File? file;
    if (Platform.isAndroid || Platform.isIOS) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result == null) return null;

      file = File(result.files.single.path!);

      return file;
    } else if (Platform.isLinux) {
      const XTypeGroup typeGroup = XTypeGroup(
        label: 'pdf',
        extensions: <String>['pdf'],
      );
      final XFile? result =
          await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

      if (result == null) return null;

      file = File(result.path);

      return file;
    }

    return null;
  }
}
