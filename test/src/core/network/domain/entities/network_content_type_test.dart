import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_content_type.dart';

void main() {
  group('NetworkContentType', () {
    test('should have correct type for json', () {
      // Arrange
      const contentType = NetworkContentType.json;

      // Act & Assert
      expect(contentType.type, equals('application/json'));
    });

    test('should have correct type for formUrlEncoded', () {
      const contentType = NetworkContentType.formUrlEncoded;
      expect(contentType.type, equals('application/x-www-form-urlencoded'));
    });

    test('should have correct type for text', () {
      const contentType = NetworkContentType.text;
      expect(contentType.type, equals('text/plain'));
    });

    test('should have all content types defined', () {
      expect(
        NetworkContentType.values,
        containsAll(
          [
            NetworkContentType.json,
            NetworkContentType.formUrlEncoded,
            NetworkContentType.text,
          ],
        ),
      );
    });
  });
}
