import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/failures/api_failure.dart';

void main() {
  group('ApiFailure', () {
    test('should create an ApiFailure with a message', () {
      // Arrange
      const String errorMessage = 'An error occurred';

      // Act
      final failure = ApiFailure(errorMessage);

      // Assert
      expect(failure.message, equals(errorMessage));
    });

    test('should create an ApiFailure with null message', () {
      // Arrange & Act
      final failure = ApiFailure(null);

      // Assert
      expect(failure.message, isNull);
    });

    test('should be an instance of Failure', () {
      // Arrange
      final failure = ApiFailure('Some error');

      // Assert
      expect(failure, isA<Failure>());
    });
  });
}
