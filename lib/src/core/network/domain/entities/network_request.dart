import 'network_content_type.dart';
import 'network_request_method.dart';
import 'network_response_type.dart';

class NetworkRequest {
  final String baseUrl;
  final String endpoint;
  final NetworkRequestMethod method;
  final Object? body;
  final NetworkContentType? contentType;
  final NetworkResponseType? responseType;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic> queryParams;
  final int? timeOut;

  NetworkRequest({
    required this.baseUrl,
    required this.endpoint,
    required this.method,
    required this.body,
    required this.contentType,
    required this.responseType,
    required this.headers,
    required this.queryParams,
    required this.timeOut,
  });

  String get url => '$baseUrl$endpoint';

  NetworkRequest copyWith({
    String? baseUrl,
    String? endpoint,
    NetworkRequestMethod? method,
    Object? body,
    NetworkContentType? contentType,
    NetworkResponseType? responseType,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    int? timeOut,
  }) {
    return NetworkRequest(
      baseUrl: baseUrl ?? this.baseUrl,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      body: body ?? this.body,
      contentType: contentType ?? this.contentType,
      responseType: responseType ?? this.responseType,
      headers: headers ?? this.headers,
      queryParams: queryParams ?? this.queryParams,
      timeOut: timeOut ?? this.timeOut,
    );
  }
}
