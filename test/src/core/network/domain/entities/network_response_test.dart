import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_response.dart';

void main() {
  group('NetworkResponse', () {
    test('should create a NetworkResponse with all required fields', () {
      // Arrange
      final response = NetworkResponse(
        {'key': 'value'},
        url: 'https://api.example.com/data',
        statusCode: 200,
        method: NetworkRequestMethod.get,
        headers: {'Content-Type': 'application/json'},
      );

      // Act & Assert
      expect(response.url, equals('https://api.example.com/data'));
      expect(response.statusCode, equals(200));
      expect(response.method, equals(NetworkRequestMethod.get));
      expect(
          response.headers, containsPair('Content-Type', 'application/json'));
      expect(response.getData(), equals({'key': 'value'}));
    });

    test('should create a NetworkResponse from JSON', () {
      // Arrange
      final jsonResponse = {
        'data': {'key': 'value'},
        'url': 'https://api.example.com/data',
        'statusCode': 200,
        'method': 'GET',
        'headers': {'Content-Type': 'application/json'},
      };

      // Act
      final response = NetworkResponse.fromJson(jsonResponse);

      // Assert
      expect(response.url, equals('https://api.example.com/data'));
      expect(response.statusCode, equals(200));
      expect(response.method, equals(NetworkRequestMethod.get));
      expect(
          response.headers, containsPair('Content-Type', 'application/json'));
      expect(response.getData(), equals({'key': 'value'}));
    });

    test('should convert string method to NetworkRequestMethod', () {
      expect('GET'.toRequestMethod(), equals(NetworkRequestMethod.get));
      expect('POST'.toRequestMethod(), equals(NetworkRequestMethod.post));
      expect('PUT'.toRequestMethod(), equals(NetworkRequestMethod.put));
      expect('PATCH'.toRequestMethod(), equals(NetworkRequestMethod.patch));
      expect('DELETE'.toRequestMethod(), equals(NetworkRequestMethod.delete));
      expect('UNKNOWN'.toRequestMethod(), isNull);
    });

    test('should copy with updated fields', () {
      final response = NetworkResponse(
        {'key': 'value'},
        url: 'https://api.example.com/data',
        statusCode: 200,
        method: NetworkRequestMethod.get,
        headers: {'Content-Type': 'application/json'},
      );

      final updatedResponse = response.copyWith(
        url: 'https://api.example.com/updated',
        statusCode: 404,
      );

      expect(updatedResponse.url, equals('https://api.example.com/updated'));
      expect(updatedResponse.statusCode, equals(404));
      expect(updatedResponse.method, equals(response.method));
      expect(updatedResponse.getData(), equals(response.getData()));
    });
  });
}
