import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/interceptor_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';

void main() {
  group('InterceptorFailure', () {
    test('should create an InterceptorFailure with all required fields', () {
      // Arrange
      final failure = InterceptorFailure(
        url: 'https://api.example.com/data',
        method: NetworkRequestMethod.get,
        type: null,
        statusCode: 500,
        message: 'Server Error',
        interceptor: 'RequestInterceptor',
      );

      // Act & Assert
      expect(failure.url, equals('https://api.example.com/data'));
      expect(failure.method, equals(NetworkRequestMethod.get));
      expect(failure.statusCode, equals(500));
      expect(failure.message, equals('Server Error'));
      expect(failure.interceptor, equals('RequestInterceptor'));
      expect(failure.type, equals(HttpFailureType.serverError));
    });

    test('should create an InterceptorFailure without interceptor', () {
      final failure = InterceptorFailure(
        url: 'https://api.example.com/data',
        method: NetworkRequestMethod.post,
        type: null,
        statusCode: 400,
        message: 'Bad Request',
      );

      expect(failure.interceptor, isNull);
      expect(failure.type, equals(HttpFailureType.badRequest));
    });
  });
}
