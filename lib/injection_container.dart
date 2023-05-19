import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/features/photo/data/datasources/photo_local_datasource.dart';
import 'package:task/features/photo/data/datasources/photo_remote_datasource.dart';
import 'package:task/features/photo/domain/repositories/photo_repository.dart';
import 'package:task/features/photo/domain/usecases/cached_photo_usecase.dart';
import 'package:task/features/photo/domain/usecases/get_local_photo_usecase.dart';
import 'package:task/features/photo/domain/usecases/get_photo_usecase.dart';
import 'package:task/features/photo/domain/usecases/search_photo_usecase.dart';

import 'core/network_info.dart';
import 'features/photo/data/repositories/photo_repository_impl.dart';
import 'features/photo/presentation/bloc/get_photos/get_photo_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! features

  //*Bloc

  sl.registerFactory(() => PhotoBloc(sl(), sl(), sl(), sl()));

  //* UseCases

  sl.registerLazySingleton(() => GetPhotoUseCase(sl()));
  sl.registerLazySingleton(() => SearchPhotoUseCase(sl()));
  sl.registerLazySingleton(() => GetPhotoLocalUseCase(sl()));
  sl.registerLazySingleton(() => CachedPhotoUseCase(sl()));

  //*Repositories

  sl.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImplement(sl(), sl(), sl()));

  //*Datasources

  sl.registerLazySingleton<PhotoRemoteDataSource>(
      () => PhotoRemoteDataSourceImplement());
  sl.registerLazySingleton<PhotoLocalDataSource>(
      () => PhotoLocalDataSourceImplement(sl()));

  //*core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //*External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
