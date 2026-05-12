import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'widgetbook_host.directories.g.dart';

/// Widgetbook entrypoint for the KeenAI design system.
void runKeenaiWidgetbook() {
  runApp(const KeenaiWidgetbookApp());
}

@App()
class KeenaiWidgetbookApp extends StatelessWidget {
  const KeenaiWidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
    );
  }
}
