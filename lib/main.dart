import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/widgets.dart';

import 'screens/holdings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DesignSystemPreviewApp());
}

/// Minimal shell without Material or Cupertino — only [WidgetsApp].
///
/// [HoldingsScreen] is the default root so `flutter run` shows that flow on
/// Chrome or an Android emulator (`-d <device>`).
class DesignSystemPreviewApp extends StatelessWidget {
  const DesignSystemPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    final view = PlatformDispatcher.instance.views.first;
    return MediaQuery(
      data: MediaQueryData.fromView(view),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: WidgetsApp(
          title: 'My Design System',
          color: const Color(0xFF111E2E),
          debugShowCheckedModeBanner: false,
          builder: (context, _) => const HoldingsScreen(),
        ),
      ),
    );
  }
}
