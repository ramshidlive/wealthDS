import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'widgetbook_host.directories.g.dart';

/// Widgetbook entrypoint for the KeenAI design system.
void runKeenaiWidgetbook() {
  runApp(const KeenaiWidgetbookApp());
}

@App()
/// Widgetbook shell for the design system (see [runKeenaiWidgetbook]).
class KeenaiWidgetbookApp extends StatelessWidget {
  const KeenaiWidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      // https://docs.widgetbook.io/addons/inspector-addon — [InspectorAddon] is from
      // `package:widgetbook` (uses `inspector`); enable in the Addons panel.
      addons: [
        InspectorAddon(),
      ],
    );
  }
}
