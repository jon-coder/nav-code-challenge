import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_response_type.dart';

void main() {
  group('NetworkResponseType', () {
    test('should have correct response type for json', () {
      // Arrange
      const responseType = NetworkResponseType.json;

      // Act & Assert
      expect(responseType.responseType, equals('json'));
    });

    test('should have correct response type for stream', () {
      const responseType = NetworkResponseType.stream;
      expect(responseType.responseType, equals('stream'));
    });

    test('should have correct response type for plain', () {
      const responseType = NetworkResponseType.plain;
      expect(responseType.responseType, equals('plain'));
    });

    test('should have correct response type for bytes', () {
      const responseType = NetworkResponseType.bytes;
      expect(responseType.responseType, equals('bytes'));
    });

    test('should have all response types defined', () {
      expect(
        NetworkResponseType.values,
        containsAll(
          [
            NetworkResponseType.json,
            NetworkResponseType.stream,
            NetworkResponseType.plain,
            NetworkResponseType.bytes,
          ],
        ),
      );
    });
  });
}
