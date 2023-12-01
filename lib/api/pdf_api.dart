import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';

class PDFApi {
  static Future<(Uint8List?, String?)> pickFile() async {
    final Uint8List fileBytes;
    final String name;

    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result == null) return (null, null);

      fileBytes = result.files.single.bytes!;
      name = result.names.single!.replaceFirst('.pdf', '');

      return (fileBytes, name);
    } else if (Platform.isAndroid || Platform.isIOS) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result == null) return (null, null);

      final file = File(result.files.single.path!);
      fileBytes = await file.readAsBytes();
      name = result.names.single!.replaceFirst('.pdf', '');

      return (fileBytes, name);
    } else if (Platform.isLinux) {
      const XTypeGroup typeGroup = XTypeGroup(
        label: 'pdf',
        extensions: <String>['pdf'],
      );
      final XFile? result =
          await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

      if (result == null) return (null, null);

      fileBytes = await result.readAsBytes();
      name = result.name.replaceFirst('.pdf', '');

      return (fileBytes, name);
    }

    return (null, null);
  }
}
