import '../../domain/entities/network_request.dart';

abstract interface class NetworkHttpClient {
  Future<Map<String, dynamic>> request(NetworkRequest request);
}
