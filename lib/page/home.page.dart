import 'dart:io';

import 'package:flutter/material.dart';

import '../api/pdf_api.dart';
import 'pdf_viewer.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToNextPage(File file) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PDFViewer(
            file: file,
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
                  final file = await PDFApi.pickFile();
                  if (file == null) return;

                  navigateToNextPage(file);
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
