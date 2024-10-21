abstract interface class Failure implements Exception {
  String? get message;
}

class ApiFailure extends Failure {
  ApiFailure(this.message);

  @override
  final String? message;
}
