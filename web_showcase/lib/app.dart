import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';

import 'components/showcase.dart';
import 'components_registry.dart';
import 'navigation/sidebar.dart';
import 'navigation/top_bar.dart';
import 'pages/component_page.dart';
import 'pages/landing_page.dart';
import 'theme/showcase_theme.dart';

class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  ThemeMode _mode = ThemeMode.light;
  String? _selectedId;

  @override
  void reassemble() {
    super.reassemble();
    // After hot reload, rebuild so the live preview reflects keenai_ds edits.
    if (mounted) setState(() {});
  }

  void _toggleTheme() {
    setState(() {
      _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _open(String id) => setState(() => _selectedId = id);
  void _goHome() => setState(() => _selectedId = null);

  @override
  Widget build(BuildContext context) {
    final atoms = atomsRegistry;
    final components = componentsRegistry;
    final all = allShowcases;
    final ComponentShowcase? selected = _selectedId == null
        ? null
        : all.firstWhere(
            (c) => c.id == _selectedId,
            orElse: () => all.first,
          );

    return MaterialApp(
      title: 'keenai_ds Showcase',
      debugShowCheckedModeBanner: false,
      themeMode: _mode,
      theme: ShowcaseTheme.light(),
      darkTheme: ShowcaseTheme.dark(),
      home: Scaffold(
        body: Inspector(
          child: SafeArea(
          child: Column(
            children: [
              TopBar(
                isDark: _mode == ThemeMode.dark,
                onToggleTheme: _toggleTheme,
                onLogoTap: _goHome,
              ),
              Expanded(
                child: Row(
                  children: [
                    Sidebar(
                      atoms: atoms,
                      components: components,
                      selectedId: _selectedId,
                      onSelected: _open,
                    ),
                    Expanded(
                      child: selected == null
                          ? LandingPage(
                              atoms: atoms,
                              components: components,
                              onOpen: _open,
                            )
                          : ComponentPage(
                              key: ValueKey(selected.id),
                              showcase: selected,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
