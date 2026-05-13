/// Small helpers shared by component showcases when emitting Dart code.

/// Renders a constructor arg `name: value,` indented two spaces and trailing
/// newline. Returns empty string if [include] is false — handy for shaving
/// default-valued args out of the snippet.
String arg(String name, String value, {bool include = true}) {
  if (!include) return '';
  return '  $name: $value,\n';
}

/// Wraps a Dart string literal: `'foo'` (escaping quotes).
String str(String s) {
  final escaped = s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
  return "'$escaped'";
}

/// `null` literal, or [str] of [value]. Returns empty string if [include]
/// is false so the arg can be omitted entirely.
String nullableStr(String name, String? value, {required bool include}) {
  if (!include) return '';
  return arg(name, value == null ? 'null' : str(value));
}
