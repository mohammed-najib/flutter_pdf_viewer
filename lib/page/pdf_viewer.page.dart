import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/pages.widget.dart';

class PDFViewer extends StatefulWidget {
  final Uint8List fileBytes;
  final String name;

  const PDFViewer({
    super.key,
    required this.fileBytes,
    required this.name,
  });

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Center(
        child: PagesWidget(
          fileBytes: widget.fileBytes,
        ),
      ),
    );
  }
}
