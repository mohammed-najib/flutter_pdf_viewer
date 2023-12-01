import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../widgets/pages.widget.dart';

class PDFViewer extends StatefulWidget {
  final File file;

  const PDFViewer({super.key, required this.file});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path).replaceFirst('.pdf', '');

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Center(
        child: PagesWidget(
          file: widget.file,
        ),
      ),
    );
  }
}
