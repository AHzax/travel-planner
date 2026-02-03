// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl extends NetworkInfo {
  final Dio dio;
  final Connectivity connectivity;

  NetworkInfoImpl({
    required this.dio,
    required this.connectivity,
  });

  @override
  Future<bool> isConnected() async {
    try {
      // Updated: connectivity_plus v5+ returns List<ConnectivityResult>
      final connectivityResults = await connectivity.checkConnectivity();

      final hasConnection = connectivityResults.any(
        (result) => result != ConnectivityResult.none,
      );

      if (!hasConnection) return false;

      // Optional: verify actual internet access
      final response = await dio
          .get('https://www.google.com')
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
