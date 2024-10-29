import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/failures/api_failure.dart';
import 'package:navalia_code_challenge/src/core/network/data/handlers/request_handler.dart';
import 'package:navalia_code_challenge/src/core/network/data/network_impl.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/interceptor_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_response.dart';

class _FakeNetworkRequest extends Fake implements NetworkRequest {}

class _FakeNetworkResponse extends Fake implements NetworkResponse {}

class _MockRequestHandler extends Mock implements RequestHandler {}

void main() {
  late NetworkImpl network;
  late RequestHandler requestHandler;
  const baseUrl = 'baseUrl';

  setUp(() {
    requestHandler = _MockRequestHandler();
    network = NetworkImpl(
      url: baseUrl,
      requestHandler: requestHandler,
    );
  });

  test('Method GET - should call RequestHandler methods', () async {
    await _testTemplate(
      network.get,
      NetworkRequestMethod.get,
      requestHandler,
      baseUrl,
    );
  });
}

Future<void> _testTemplate(
  Future<Either<Failure, NetworkResponse>> Function(String endpoint) callback,
  NetworkRequestMethod method,
  RequestHandler requestHandler,
  String baseUrl,
) async {
  const endpoint = 'enpoint';
  final request = Right<InterceptorFailure, NetworkRequest>(
    _FakeNetworkRequest(),
  );
  final response = _FakeNetworkResponse();

  when(() => requestHandler.prepareRequest(
        method,
        baseUrl,
        endpoint,
        contentType: any(named: 'contentType'),
        body: any(named: 'body'),
      )).thenAnswer((_) async => request);

  when(() => requestHandler.executeRequest(request))
      .thenAnswer((_) async => Right(response));

  await callback(endpoint);

  verify(() => requestHandler.prepareRequest(
        method,
        baseUrl,
        endpoint,
        contentType: any(named: 'contentType'),
        body: any(named: 'body'),
      )).called(1);
  verify(() => requestHandler.executeRequest(request)).called(1);
}
