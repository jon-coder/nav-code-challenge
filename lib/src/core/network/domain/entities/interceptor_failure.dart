import 'network_failure.dart';

class InterceptorFailure extends NetworkFailure {
  InterceptorFailure({
    required super.url,
    required super.method,
    required super.type,
    required super.statusCode,
    required super.message,
    this.interceptor,
  });

  final String? interceptor;
}
