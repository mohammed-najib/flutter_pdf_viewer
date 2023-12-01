import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

enum ZoomLevel {
  one,
  two,
}

class PagesWidget extends StatefulWidget {
  final Uint8List fileBytes;

  const PagesWidget({
    super.key,
    required this.fileBytes,
  });

  @override
  State<PagesWidget> createState() => _PagesWidgetState();
}

class _PagesWidgetState extends State<PagesWidget> {
  final controller = TransformationController();

  ZoomLevel zoomLevel = ZoomLevel.one;

  void changeZoomLevel() {
    setState(() {
      if (zoomLevel == ZoomLevel.one) {
        controller.value = controller.value.scaled(2.0);
        zoomLevel = ZoomLevel.two;
      } else {
        controller.value = controller.value.scaled(0.5);
        zoomLevel = ZoomLevel.one;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview.builder(
      allowPrinting: false,
      allowSharing: false,
      canDebug: false,
      canChangeOrientation: false,
      canChangePageFormat: false,
      build: (format) {
        return widget.fileBytes;
      },
      pagesBuilder: (context, pages) {
        return InteractiveViewer(
          scaleEnabled: false,
          transformationController: controller,
          constrained: false,
          child: SizedBox(
            height: pages
                    .map((e) => e.height)
                    .reduce((value, element) => value + element + 24)
                    .toDouble() +
                24,
            width: MediaQuery.of(context).size.width > pages[0].width.toDouble()
                ? MediaQuery.of(context).size.width
                : pages[0].width.toDouble(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: pages
                  .map((page) => SizedBox(
                        height: page.height.toDouble() + 24,
                        width: page.width.toDouble(),
                        child: InkWell(
                          onDoubleTap: changeZoomLevel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Image(
                                height: page.height.toDouble(),
                                width: page.width.toDouble(),
                                image: page.image,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
