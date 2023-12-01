import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/pdf_api.dart';
import 'pdf_viewer.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToNextPage(Uint8List fileBytes, String name) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PDFViewer(
            fileBytes: fileBytes,
            name: name,
          ),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final (fileBytes, name) = await PDFApi.pickFile();
                  if (fileBytes == null || name == null) return;

                  navigateToNextPage(fileBytes, name);
                },
                child: const Text('File PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
