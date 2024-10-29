import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/json_utils/json_parse.dart';
import 'package:navalia_code_challenge/src/core/typedef/typedef.dart';

void main() {
  group('JsonUtils', () {
    test('parseFromString returns null for null input', () {
      expect(JsonUtils.parseFromString(null), isNull);
    });

    test('parseFromString returns null for empty string', () {
      expect(JsonUtils.parseFromString(''), isNull);
    });

    test('parseFromString parses valid JSON', () {
      const jsonString = '{"key": "value"}';
      final result = JsonUtils.parseFromString(jsonString);
      expect(result, isA<Json>());
    });

    test('parseFromString returns null for invalid JSON', () {
      const jsonString = '{key: value}';
      expect(JsonUtils.parseFromString(jsonString), isNull);
    });
  });

  group('JsonListUtils', () {
    test('parseFromString returns null for null input', () {
      expect(JsonListUtils.parseFromString(null), isNull);
    });

    test('parseFromString returns null for empty string', () {
      expect(JsonListUtils.parseFromString(''), isNull);
    });

    test('parseFromString parses valid JSON array', () {
      const jsonString = '[{"key": "value1"}, {"key": "value2"}]';
      final result = JsonListUtils.parseFromString(jsonString);
      expect(result, isA<JsonList>());
    });

    test('parseFromString returns null for invalid JSON', () {
      const jsonString = '[{"key": "value1"}, {key: value2}]';
      expect(JsonListUtils.parseFromString(jsonString), isNull);
    });
  });
}
