import 'dart:convert';

import '../typedef/typedef.dart';

class JsonUtils {
  static Json? parseFromString(String? jsonText) {
    if (jsonText == null || jsonText.isEmpty) return null;
    try {
      return Json.from(json.decode(jsonText));
    } catch (_) {
      return null;
    }
  }
}

class JsonListUtils {
  static JsonList? parseFromString(String? jsonText) {
    if (jsonText == null || jsonText.isEmpty) return null;
    try {
      return JsonList.from(json.decode(jsonText));
    } catch (_) {
      return null;
    }
  }
}
