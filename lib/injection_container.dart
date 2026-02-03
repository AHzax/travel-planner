import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  sl.registerFactory(() => NetworkInfoImpl(dio: sl(), connectivity: sl()));

  //* Blocs
  // sl.registerFactory(() => MainBloc());

  //* Repos
/*   sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: sl(),
      auth: sl(),
    ),
  ); */

  //* Use Cases
/*   sl.registerLazySingleton(
    () => RegisterUserUC(
      repo: sl(),
    ),
  ); */

  //* Data sources
  // sl.registerFactory(() => AuthRemoteDatasourceImpl(dio: sl()));

  //! External
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPref);
  sl.registerFactory(() => Connectivity());
  sl.registerFactory(() => Dio(BaseOptions(
        headers: {
          'Content-Type': 'application/json', // Replace with your token
        },
        baseUrl: " APIConst.baseUrl",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      )));
}
