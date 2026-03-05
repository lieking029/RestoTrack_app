/// Converts a snake_case string to camelCase.
String _snakeToCamel(String input) {
  return input.replaceAllMapped(
    RegExp(r'_([a-z])'),
    (match) => match.group(1)!.toUpperCase(),
  );
}

/// Recursively normalizes all keys in a JSON map to camelCase.
/// Handles both snake_case and already-camelCase keys.
Map<String, dynamic> normalizeJsonKeys(Map<String, dynamic> json) {
  return json.map((key, value) {
    final camelKey = _snakeToCamel(key);
    return MapEntry(camelKey, _normalizeValue(value));
  });
}

dynamic _normalizeValue(dynamic value) {
  if (value is Map<String, dynamic>) {
    return normalizeJsonKeys(value);
  }
  if (value is List) {
    return value.map(_normalizeValue).toList();
  }
  return value;
}
