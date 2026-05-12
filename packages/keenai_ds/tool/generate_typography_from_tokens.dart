// Regenerates lib/tokens/typography_generated.dart from lib/tokens/tokens.json.
// Run from package root: dart run tool/generate_typography_from_tokens.dart

import 'dart:convert';
import 'dart:io';

void main() {
  final root = Directory.current.path;
  final jsonFile = File('$root/lib/tokens/tokens.json');
  final outFile = File('$root/lib/tokens/typography_generated.dart');

  if (!jsonFile.existsSync()) {
    stderr.writeln('Missing ${jsonFile.path}');
    exitCode = 1;
    return;
  }

  final map = jsonDecode(jsonFile.readAsStringSync()) as Map<String, dynamic>;
  final typo = map['typography'] as Map<String, dynamic>? ?? {};

  final body = typo['body'] as Map<String, dynamic>? ?? {};
  final display = typo['display'] as Map<String, dynamic>? ?? {};

  final buf = StringBuffer()
    ..writeln('// GENERATED FILE — do not edit by hand.')
    ..writeln('// Source: lib/tokens/tokens.json → typography')
    ..writeln('// Regenerate: dart run tool/generate_typography_from_tokens.dart')
    ..writeln()
    ..writeln("import 'package:flutter/painting.dart';")
    ..writeln();

  _emitDimsClass(buf, 'KeenaiTypographyBodyDims', 'body', body);
  _emitDimsClass(buf, 'KeenaiTypographyDisplayDims', 'display', display);
  _emitStyleClass(buf, 'KeenaiTypographyBody', 'KeenaiTypographyBodyDims', 'body', body);
  _emitStyleClass(
    buf,
    'KeenaiTypographyDisplay',
    'KeenaiTypographyDisplayDims',
    'display',
    display,
  );

  outFile.writeAsStringSync(buf.toString());
  stdout.writeln('Wrote ${outFile.path}');
}

void _emitDimsClass(
  StringBuffer buf,
  String className,
  String group,
  Map<String, dynamic> styles,
) {
  buf.writeln('/// Raw font metrics from `tokens.json` → `typography.$group`.');
  buf.writeln('abstract final class $className {');
  buf.writeln('  const $className._();');
  for (final key in styles.keys.toList()..sort()) {
    final id = _styleId(group, key);
    final props = styles[key] as Map<String, dynamic>;
    final fs = _dim(props['fontSize']);
    final lh = _dim(props['lineHeight']);
    buf.writeln();
    buf.writeln('  /// `$group` → "$key" (fontSize)');
    buf.writeln('  static const double ${id}FontSize = $fs;');
    buf.writeln('  /// `$group` → "$key" (lineHeight)');
    buf.writeln('  static const double ${id}LineHeight = $lh;');
  }
  buf.writeln('}');
  buf.writeln();
}

void _emitStyleClass(
  StringBuffer buf,
  String className,
  String dimsClass,
  String group,
  Map<String, dynamic> styles,
) {
  buf.writeln('/// Text styles from `tokens.json` → `typography.$group`.');
  buf.writeln('abstract final class $className {');
  buf.writeln('  const $className._();');
  for (final key in styles.keys.toList()..sort()) {
    final id = _styleId(group, key);
    final props = styles[key] as Map<String, dynamic>;
    final ls = _dim(props['letterSpacing']);
    final fw =
        ((props['fontWeight'] as Map<String, dynamic>)['value'] as num).toInt();
    final ff = (props['fontFamily'] as Map<String, dynamic>)['value'] as String;
    final fwDart = _fontWeight(fw);

    buf.writeln();
    buf.writeln('  /// `$group` → "$key"');
    buf.writeln('  static TextStyle get $id => TextStyle(');
    buf.writeln("    fontFamily: '$ff',");
    buf.writeln('    fontSize: $dimsClass.${id}FontSize,');
    buf.writeln(
      '    height: $dimsClass.${id}LineHeight / $dimsClass.${id}FontSize,',
    );
    buf.writeln('    fontWeight: $fwDart,');
    buf.writeln('    letterSpacing: $ls,');
    buf.writeln('  );');
  }
  buf.writeln('}');
  buf.writeln();
}

/// JSON key e.g. `10 semibold` → getter `body10Semibold` / `display22Semibold`.
String _styleId(String group, String jsonKey) {
  final parts = jsonKey.split(RegExp(r'\s+'));
  if (parts.length != 2) {
    throw FormatException('Expected "<size> <weight>" token name, got: $jsonKey');
  }
  final size = parts[0];
  final w = _weightSuffix(parts[1]);
  return '$group$size$w';
}

String _weightSuffix(String w) {
  return switch (w.toLowerCase()) {
    'regular' => 'Regular',
    'medium' => 'Medium',
    'semibold' => 'Semibold',
    _ => throw FormatException('Unknown font weight label: $w'),
  };
}

double _dim(Object? node) {
  if (node is! Map<String, dynamic>) return 0;
  final v = node['value'];
  if (v is num) return v.toDouble();
  return 0;
}

String _fontWeight(int w) {
  return switch (w) {
    100 => 'FontWeight.w100',
    200 => 'FontWeight.w200',
    300 => 'FontWeight.w300',
    400 => 'FontWeight.w400',
    500 => 'FontWeight.w500',
    600 => 'FontWeight.w600',
    700 => 'FontWeight.w700',
    800 => 'FontWeight.w800',
    900 => 'FontWeight.w900',
    _ => 'FontWeight.w400',
  };
}
