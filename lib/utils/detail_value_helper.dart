import 'package:flutter/widgets.dart';

/// Finds a value inside [details] for the provided [key].
/// It automatically checks multiple variants of the key such as camelCase,
/// snake_case and lowercase. Optional [aliases] can be provided for special
/// cases (e.g. different spellings).
String? detailValue(
  Map<String, dynamic> details,
  String key, {
  List<String>? aliases,
}) {
  final candidates = <String>{
    key,
    key.toLowerCase(),
    _camelToSnake(key),
    _removeUnderscores(key),
  }..removeWhere((element) => element.isEmpty);

  if (aliases != null) {
    for (final alias in aliases) {
      if (alias.isEmpty) continue;
      candidates.add(alias);
      candidates.add(alias.toLowerCase());
      candidates.add(_camelToSnake(alias));
      candidates.add(_removeUnderscores(alias));
    }
  }

  for (final candidate in candidates) {
    if (candidate.isEmpty) continue;
    if (!details.containsKey(candidate)) continue;
    final value = details[candidate];
    if (value == null) continue;
    final text = value.toString();
    if (text.isEmpty) continue;
    return text;
  }

  return null;
}

/// Convenience helper that assigns the value from [details] into [controller].
void setControllerFromDetails(
  Map<String, dynamic> details,
  TextEditingController controller,
  String key, {
  List<String>? aliases,
}) {
  final value = detailValue(details, key, aliases: aliases);
  if (value != null) {
    controller.text = value;
  }
}

void populateControllers(
  Map<String, dynamic> details,
  Map<String, TextEditingController> mapping, {
  Map<String, List<String>>? aliasMap,
}) {
  mapping.forEach((key, controller) {
    final aliases = aliasMap?[key];
    setControllerFromDetails(details, controller, key, aliases: aliases);
  });
}

List<String> detailList(
  Map<String, dynamic> details,
  String key, {
  List<String>? aliases,
  Pattern delimiter = ',',
  bool keepEmpty = false,
}) {
  final raw = detailValue(details, key, aliases: aliases);
  if (raw == null || raw.trim().isEmpty) return <String>[];
  final parts = raw.split(delimiter);
  return parts
      .map((segment) => _cleanSegment(segment))
      .where((value) => keepEmpty || value.isNotEmpty)
      .toList();
}

void setControllersFromList(
  List<TextEditingController> controllers,
  List<String> values,
) {
  for (int i = 0; i < controllers.length && i < values.length; i++) {
    final value = values[i].trim();
    if (value.isEmpty) continue;
    controllers[i].text = value;
  }
}

String _cleanSegment(String value) {
  final trimmed = value.replaceAll('\n', ' ').replaceAll('\r', ' ').trim();
  if (trimmed.isEmpty) return '';
  final lower = trimmed.toLowerCase();
  if (lower == 'nan' || lower == 'null' || lower == 'undefined') {
    return '';
  }
  return trimmed;
}

String _camelToSnake(String input) {
  if (input.isEmpty) return '';
  final buffer = StringBuffer();
  for (int i = 0; i < input.length; i++) {
    final String char = input[i];
    if (_isUpperCase(char) && i > 0 && !_isUpperCase(input[i - 1])) {
      buffer.write('_');
      buffer.write(char.toLowerCase());
    } else {
      buffer.write(char.toLowerCase());
    }
  }
  return buffer.toString();
}

String _removeUnderscores(String input) => input.replaceAll('_', '');

bool _isUpperCase(String char) =>
    char.toUpperCase() == char && char.toLowerCase() != char;

