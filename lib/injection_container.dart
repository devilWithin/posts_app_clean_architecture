import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post_use_case.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_posts_use_case.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'features/posts/data/datasources/post_local_data_source.dart';
import 'features/posts/data/datasources/post_remote_data_source.dart';
import 'features/posts/data/repositories/posts_repository_impl.dart';
import 'features/posts/domain/usecases/get_all_posts_use_case.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/bloc/get_all_posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(
        getAllPostsUseCase: sl(),
      ));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPostUseCase: sl(), updatePostUseCase: sl(), deletePostUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(postsRepository: sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
