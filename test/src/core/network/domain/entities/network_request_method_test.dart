import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';

void main() {
  group('NetworkRequestMethod', () {
    test('should have correct method for GET', () {
      // Arrange
      const method = NetworkRequestMethod.get;

      // Act & Assert
      expect(method.method, equals('GET'));
    });

    test('should have correct method for POST', () {
      const method = NetworkRequestMethod.post;
      expect(method.method, equals('POST'));
    });

    test('should have correct method for PUT', () {
      const method = NetworkRequestMethod.put;
      expect(method.method, equals('PUT'));
    });

    test('should have correct method for PATCH', () {
      const method = NetworkRequestMethod.patch;
      expect(method.method, equals('PATCH'));
    });

    test('should have correct method for DELETE', () {
      const method = NetworkRequestMethod.delete;
      expect(method.method, equals('DELETE'));
    });

    test('should have all methods defined', () {
      expect(
        NetworkRequestMethod.values,
        containsAll(
          [
            NetworkRequestMethod.get,
            NetworkRequestMethod.post,
            NetworkRequestMethod.put,
            NetworkRequestMethod.patch,
            NetworkRequestMethod.delete,
          ],
        ),
      );
    });
  });
}
