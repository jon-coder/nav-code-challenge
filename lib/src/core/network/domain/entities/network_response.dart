import 'dart:convert';

import '../../../json_utils/json_parse.dart';
import '../../../typedef/typedef.dart';
import 'network_request_method.dart';

class NetworkResponse {
  NetworkResponse(
    this._data, {
    required this.url,
    required this.statusCode,
    required this.method,
    required this.headers,
  });

  final String url;
  final int statusCode;
  final NetworkRequestMethod method;
  final Map<String, dynamic> headers;
  final dynamic _data;

  factory NetworkResponse.fromJson(Map<String, dynamic> json) {
    return NetworkResponse(
      json['data'],
      url: json['url'],
      statusCode: json['statusCode'],
      method: (json['method']).toString().toRequestMethod() ??
          NetworkRequestMethod.get,
      headers: json['headers'],
    );
  }

  Json get jsonData => JsonUtils.parseFromString(jsonEncode(_data)) ?? {};

  JsonList get jsonListData =>
      JsonListUtils.parseFromString(jsonEncode(_data)) ?? <Json>[];

  dynamic getData() => _data;

  NetworkResponse copyWith({
    String? url,
    int? statusCode,
    NetworkRequestMethod? method,
    Map<String, dynamic>? headers,
    dynamic data,
  }) {
    return NetworkResponse(
      data ?? _data,
      url: url ?? this.url,
      statusCode: statusCode ?? this.statusCode,
      method: method ?? this.method,
      headers: headers ?? this.headers,
    );
  }
}

extension NetworkStringExtension on String {
  NetworkRequestMethod? toRequestMethod() {
    switch (this) {
      case 'GET':
        return NetworkRequestMethod.get;
      case 'POST':
        return NetworkRequestMethod.post;
      case 'PUT':
        return NetworkRequestMethod.put;
      case 'PATCH':
        return NetworkRequestMethod.patch;
      case 'DELETE':
        return NetworkRequestMethod.delete;
      default:
        return null;
    }
  }
}
