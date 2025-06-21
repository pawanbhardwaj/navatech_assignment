import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:navatech_assignment/blocs/album_bloc.dart';
import 'package:navatech_assignment/data/datasources/album_remote_data_source.dart';
import 'package:navatech_assignment/data/datasources/photo_remote_data_source.dart';
import 'package:navatech_assignment/data/models/album_model.dart';
import 'package:navatech_assignment/repositories/album_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final albumBox = await Hive.openBox<AlbumModel>('albumsBox');

  getIt.registerLazySingleton(() => http.Client());
  getIt.registerSingleton<Box<AlbumModel>>(albumBox);
  // Dio instance
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Data sources using Dio
  getIt.registerLazySingleton(() => AlbumRemoteDataSource(getIt<Dio>()));
  getIt.registerLazySingleton(() => PhotoRemoteDataSource(getIt<Dio>()));

  // Repository
  getIt.registerLazySingleton<AlbumRepository>(
    () => AlbumRepository(
        getIt<AlbumRemoteDataSource>(), getIt<PhotoRemoteDataSource>()),
  );

  // Bloc
  getIt.registerFactory(() => AlbumBloc(albumRepository: getIt()));
}
