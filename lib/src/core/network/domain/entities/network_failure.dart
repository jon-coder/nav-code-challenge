import '../../../failures/api_failure.dart';
import 'network_request_method.dart';

class NetworkFailure implements ApiFailure {
  NetworkFailure({
    required this.message,
    required this.statusCode,
    required this.url,
    required HttpFailureType? type,
    required this.method,
  }) : _type = type;

  @override
  final String? message;
  final int? statusCode;
  final String? url;
  final HttpFailureType? _type;
  final NetworkRequestMethod? method;

  HttpFailureType get type => _type ?? typeFromStatusCode;

  HttpFailureType get typeFromStatusCode {
    switch (statusCode) {
      case 400:
        return HttpFailureType.badRequest;
      case 401:
        return HttpFailureType.unauthorized;
      case 403:
        return HttpFailureType.forbidden;
      case 404:
        return HttpFailureType.notFound;
      case 408:
        return HttpFailureType.timeout;
      case 422:
        return HttpFailureType.unprocessableContent;
      case 500:
        return HttpFailureType.serverError;
      default:
        return HttpFailureType.error;
    }
  }

  NetworkFailure copyWith({
    String? message,
    int? statusCode,
    String? url,
    HttpFailureType? type,
    NetworkRequestMethod? method,
  }) {
    return NetworkFailure(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      url: url ?? this.url,
      type: type ?? _type,
      method: method ?? this.method,
    );
  }
}

enum HttpFailureType {
  badRequest('400'),
  unauthorized('401'),
  forbidden('403'),
  notFound('404'),
  timeout('408'),
  unprocessableContent('422'),
  serverError('500'),
  receiveTimeout('timeout'),
  error('');

  const HttpFailureType(this.type);
  final String type;
}
