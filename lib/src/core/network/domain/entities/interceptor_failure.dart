import 'network_failure.dart';

class InterceptorFailure extends NetworkFailure {
  InterceptorFailure({
    required super.message,
    required super.url,
    required super.method,
    super.type,
    super.statusCode,
    this.interceptor,
  });

  final String? interceptor;
}
