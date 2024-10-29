import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_content_type.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_response_type.dart';

void main() {
  group('NetworkRequest', () {
    test('should create a NetworkRequest with all required fields', () {
      // Arrange
      final request = NetworkRequest(
        baseUrl: 'https://api.example.com',
        endpoint: '/data',
        method: NetworkRequestMethod.get,
        body: null,
        contentType: NetworkContentType.json,
        responseType: NetworkResponseType.json,
        headers: {'Authorization': 'Bearer token'},
        queryParams: {'search': 'query'},
        timeOut: 30,
      );

      // Act & Assert
      expect(request.baseUrl, equals('https://api.example.com'));
      expect(request.endpoint, equals('/data'));
      expect(request.method, equals(NetworkRequestMethod.get));
      expect(request.body, isNull);
      expect(request.contentType, equals(NetworkContentType.json));
      expect(request.responseType, equals(NetworkResponseType.json));
      expect(request.headers, containsPair('Authorization', 'Bearer token'));
      expect(request.queryParams, containsPair('search', 'query'));
      expect(request.timeOut, equals(30));
    });

    test('should return the correct url', () {
      final request = NetworkRequest(
        baseUrl: 'https://api.example.com',
        endpoint: '/data',
        method: NetworkRequestMethod.get,
        body: null,
        contentType: NetworkContentType.json,
        responseType: NetworkResponseType.json,
        headers: null,
        queryParams: {},
        timeOut: null,
      );

      expect(request.url, equals('https://api.example.com/data'));
    });

    test('should copy with updated fields', () {
      final request = NetworkRequest(
        baseUrl: 'https://api.example.com',
        endpoint: '/data',
        method: NetworkRequestMethod.get,
        body: null,
        contentType: NetworkContentType.json,
        responseType: NetworkResponseType.json,
        headers: null,
        queryParams: {},
        timeOut: null,
      );

      final updatedRequest = request.copyWith(
        endpoint: '/new-data',
        method: NetworkRequestMethod.post,
      );

      expect(updatedRequest.endpoint, equals('/new-data'));
      expect(updatedRequest.method, equals(NetworkRequestMethod.post));
      expect(updatedRequest.baseUrl, equals(request.baseUrl));
    });

    test('should copy with all fields updated', () {
      final request = NetworkRequest(
        baseUrl: 'https://api.example.com',
        endpoint: '/data',
        method: NetworkRequestMethod.get,
        body: null,
        contentType: NetworkContentType.json,
        responseType: NetworkResponseType.json,
        headers: null,
        queryParams: {},
        timeOut: null,
      );

      final updatedRequest = request.copyWith(
        baseUrl: 'https://api.new.com',
        endpoint: '/new-data',
        method: NetworkRequestMethod.post,
        body: {'key': 'value'},
        contentType: NetworkContentType.formUrlEncoded,
        responseType: NetworkResponseType.stream,
        headers: {'Authorization': 'Bearer new_token'},
        queryParams: {'search': 'new_query'},
        timeOut: 60,
      );

      expect(updatedRequest.baseUrl, equals('https://api.new.com'));
      expect(updatedRequest.endpoint, equals('/new-data'));
      expect(updatedRequest.method, equals(NetworkRequestMethod.post));
      expect(updatedRequest.body, equals({'key': 'value'}));
      expect(updatedRequest.contentType,
          equals(NetworkContentType.formUrlEncoded));
      expect(updatedRequest.responseType, equals(NetworkResponseType.stream));
      expect(updatedRequest.headers,
          containsPair('Authorization', 'Bearer new_token'));
      expect(updatedRequest.queryParams, containsPair('search', 'new_query'));
      expect(updatedRequest.timeOut, equals(60));
    });
  });
}
