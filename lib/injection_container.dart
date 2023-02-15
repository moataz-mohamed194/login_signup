import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/auth/ domain/repositories/Login_repositorie.dart';
import 'features/auth/ domain/usecases/create_user.dart';
import 'features/auth/ domain/usecases/login_usecases.dart';
import 'features/auth/data/datasources/login_remote_date_source.dart';
import 'features/auth/data/repositories/login_repositories.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  //Bloc
  sl.registerFactory(() => LoginBloc(loginMethod: sl(), createUseMethod: sl()));

  //UseCase
  sl.registerLazySingleton(() => CreateUseCases(sl()));
  sl.registerLazySingleton(() => LoginUseCases(sl()));

  //Repository
  sl.registerLazySingleton<LoginRepositorie>(
      () => LoginRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Datasources

  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImple(client: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
