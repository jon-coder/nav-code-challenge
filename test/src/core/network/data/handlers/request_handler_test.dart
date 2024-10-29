import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/network/data/handlers/interceptor_handler.dart';
import 'package:navalia_code_challenge/src/core/network/data/handlers/request_handler.dart';
import 'package:navalia_code_challenge/src/core/network/data/interfaces/network_http_client.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/interceptor_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_response.dart';

class _MockNetworkHttpClient extends Mock implements NetworkHttpClient {}

class _MockInterceptorHandler extends Mock implements InterceptorHandler {}

class _FakeNetworkRequest extends Fake implements NetworkRequest {}

class _FakeNetworkResponse extends Fake implements NetworkResponse {}

class _FakeInterceptorFailure extends Fake implements InterceptorFailure {
  @override
  int? get statusCode => -1;

  @override
  String get message => '';
}

class _FakeNetworkFailure extends Fake implements NetworkFailure {}

void main() {
  late RequestHandler requestHandler;
  late NetworkHttpClient httpClient;
  late InterceptorHandler interceptorHandler;

  setUp(() {
    httpClient = _MockNetworkHttpClient();
    interceptorHandler = _MockInterceptorHandler();
    requestHandler = RequestHandler(httpClient, interceptorHandler);
  });

  setUpAll(() {
    registerFallbackValue(_FakeNetworkRequest());
    registerFallbackValue(_FakeNetworkResponse());
    registerFallbackValue(_FakeNetworkFailure());
  });

  group('Method prepareRequest -', () {
    test('Should return [$Left] when [$InterceptorHandler] fails', () async {
      when(() => interceptorHandler.onRequest(any())).thenAnswer(
        (_) async => Left(_FakeInterceptorFailure()),
      );

      final result = await requestHandler.prepareRequest(
        NetworkRequestMethod.get,
        'baseUrl',
        'endpoint',
      );

      expect(result, isA<Left>());
      result.fold(
        (failure) {
          expect(failure, isA<InterceptorFailure>());
        },
        (result) => fail('Expected an error, but got a NetworkRequest'),
      );
      verify(() => interceptorHandler.onRequest(any())).called(1);
      verifyNoMoreInteractions(interceptorHandler);
    });

    test('Should return [$Right] when [$InterceptorHandler] succeeds',
        () async {
      when(() => interceptorHandler.onRequest(any())).thenAnswer(
        (_) async => Right(_FakeNetworkRequest()),
      );

      final result = await requestHandler.prepareRequest(
        NetworkRequestMethod.get,
        'baseUrl',
        'endpoint',
      );

      expect(result, isA<Right>());
      result.fold(
          (failure) => fail('Expected an NetworkRequest, but got a fail'),
          (result) => expect(result, isA<NetworkRequest>()));
      verify(() => interceptorHandler.onRequest(any())).called(1);
      verifyNoMoreInteractions(interceptorHandler);
    });
  });

  group('Method execute request -', () {
    test('Should return [$Left] when input request is [$Left]', () async {
      final req =
          Left<InterceptorFailure, NetworkRequest>(_FakeInterceptorFailure());
      when(() => interceptorHandler.onError(any()))
          .thenAnswer((_) async => _FakeNetworkFailure());

      final result = await requestHandler.executeRequest(req);

      expect(result, isA<Left>());
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
        },
        (resp) => fail('Expected an NetworkFailure, but got a NetworkResponse'),
      );
      verifyNoMoreInteractions(interceptorHandler);
    });

    test(
        'Sould return [$Left] when [$InterceptorHandler] onResponse returns [$Left]',
        () async {
      final request =
          Right<InterceptorFailure, NetworkRequest>(_FakeNetworkRequest());

      request
          .fold(
              (failure) => fail('Must return NetworkRequest'),
              (req) => when(
                    () => httpClient.request(req),
                  ))
          .thenAnswer(
            (_) async => {
              'data': '',
              'url': '',
              'statusCode': 200,
              'method': 'get',
              'headers': {'data': ''},
            },
          );

      when(() => interceptorHandler.onResponse(any())).thenAnswer(
        (_) async => Left(_FakeInterceptorFailure()),
      );

      when(() => interceptorHandler.onError(any())).thenAnswer(
        (_) async => _FakeNetworkFailure(),
      );

      final result = await requestHandler.executeRequest(request);

      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (resp) => fail('Must be a network failure'),
      );
      verify(() =>
              httpClient.request(request.getOrElse(() => throw Exception())))
          .called(1);
      verify(() => interceptorHandler.onResponse(any())).called(1);
      verifyNoMoreInteractions(httpClient);
      verifyNoMoreInteractions(interceptorHandler);
    });

    test('Should return [$Right] when all actions succeed', () async {
      final request =
          Right<InterceptorFailure, NetworkRequest>(_FakeNetworkRequest());

      request
          .fold(
              (failure) => fail('Must return NetworkRequest'),
              (req) => when(
                    () => httpClient.request(req),
                  ))
          .thenAnswer(
            (_) async => {
              'data': '',
              'url': '',
              'statusCode': 200,
              'method': 'get',
              'headers': {'data': ''},
            },
          );

      final response = _FakeNetworkResponse();
      when(() => interceptorHandler.onResponse(any()))
          .thenAnswer((_) async => Right(response));

      final result = await requestHandler.executeRequest(request);

      expect(result, isA<Right>());
      result.fold((failure) => fail('Must be a NetworkResponse'), (resp) {
        expect(response, isA<NetworkResponse>());
      });
      verify(() =>
              httpClient.request(request.getOrElse(() => throw Exception())))
          .called(1);
      verify(() => interceptorHandler.onResponse(any())).called(1);
      verifyNoMoreInteractions(httpClient);
      verifyNoMoreInteractions(interceptorHandler);
    });
  });
}
