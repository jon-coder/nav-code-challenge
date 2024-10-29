import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';

void main() {
  group('NetworkFailure', () {
    test('should create a NetworkFailure with all required fields', () {
      // Arrange
      final failure = NetworkFailure(
        message: 'Not Found',
        statusCode: 404,
        url: 'https://api.example.com/data',
        type: null,
        method: NetworkRequestMethod.get,
      );

      // Act & Assert
      expect(failure.message, equals('Not Found'));
      expect(failure.statusCode, equals(404));
      expect(failure.url, equals('https://api.example.com/data'));
      expect(failure.method, equals(NetworkRequestMethod.get));
      expect(failure.type, equals(HttpFailureType.notFound));
    });

    test('should return HttpFailureType based on statusCode', () {
      expect(
          NetworkFailure(
            message: 'Bad Request',
            statusCode: 400,
            url: '',
            type: null,
            method: NetworkRequestMethod.post,
          ).type,
          equals(HttpFailureType.badRequest));

      expect(
          NetworkFailure(
            message: 'Unauthorized',
            statusCode: 401,
            url: '',
            type: null,
            method: NetworkRequestMethod.get,
          ).type,
          equals(HttpFailureType.unauthorized));

      expect(
          NetworkFailure(
            message: 'Forbidden',
            statusCode: 403,
            url: '',
            type: null,
            method: NetworkRequestMethod.get,
          ).type,
          equals(HttpFailureType.forbidden));

      expect(
          NetworkFailure(
            message: 'Not Found',
            statusCode: 404,
            url: '',
            type: null,
            method: NetworkRequestMethod.get,
          ).type,
          equals(HttpFailureType.notFound));

      expect(
          NetworkFailure(
            message: 'Timeout',
            statusCode: 408,
            url: '',
            type: null,
            method: NetworkRequestMethod.get,
          ).type,
          equals(HttpFailureType.timeout));

      expect(
          NetworkFailure(
            message: 'Unprocessable Content',
            statusCode: 422,
            url: '',
            type: null,
            method: NetworkRequestMethod.get,
          ).type,
          equals(HttpFailureType.unprocessableContent));

      expect(
          NetworkFailure(
            message: 'Server Error',
            statusCode: 500,
            url: '',
            type: null,
            method: NetworkRequestMethod.get,
          ).type,
          equals(HttpFailureType.serverError));

      expect(
          NetworkFailure(
            message: 'Unknown Error',
            statusCode: 999,
            url: '',
            type: null,
            method: NetworkRequestMethod.get,
          ).type,
          equals(HttpFailureType.error));
    });

    test('should copy with updated fields', () {
      final failure = NetworkFailure(
        message: 'Not Found',
        statusCode: 404,
        url: 'https://api.example.com/data',
        type: null,
        method: NetworkRequestMethod.get,
      );

      final updatedFailure = failure.copyWith(
        message: 'Updated Message',
        statusCode: 500,
      );

      expect(updatedFailure.message, equals('Updated Message'));
      expect(updatedFailure.statusCode, equals(500));
      expect(updatedFailure.url, equals(failure.url));
      expect(updatedFailure.type, equals(HttpFailureType.serverError));
    });
  });
}
