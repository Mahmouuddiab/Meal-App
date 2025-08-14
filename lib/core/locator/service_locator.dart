import 'package:get_it/get_it.dart';
import 'package:meal_app/core/secrets/app_secrets.dart';
import 'package:meal_app/features/Home/Data/Datasource/HomeDataSource.dart';
import 'package:meal_app/features/Home/Data/Repository/Repository.dart';
import 'package:meal_app/features/Home/Domain/Repository/Repository.dart';
import 'package:meal_app/features/Home/presentation/Cubit/home_cubit.dart';
import 'package:meal_app/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:meal_app/features/favorites/data/data_sources/favorites_remote_data_source.dart';
import 'package:meal_app/features/favorites/data/repository/favorites_repository_impl.dart';
import 'package:meal_app/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/current_user.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecse.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependices() async {
  final supabse = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerSingleton<SupabaseClient>(supabse.client);
  initAuth();

  initHome();
  initFavorites();
}

void initAuth() {
  // Data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Use-cases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserSignIn(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        currentUser: serviceLocator(),
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
      ),
    );
}

void initHome() {
  serviceLocator
    // Repository
    ..registerFactory<MealsRepository>(
      () => MealsRepositoryImpl(serviceLocator()),
    )
    // Cubit
    ..registerFactory<HomeCubit>(() => (HomeCubit(serviceLocator())))
    //FavoritesRemoteDataSource
    ..registerFactory<MealsRemoteDataSource>(
      () => MealsRemoteDataSource(serviceLocator()),
    );
}

void initFavorites() {
  serviceLocator
    // Repository
    ..registerFactory<FavoritesRepository>(
      () => FavoritesRepositoryImpl(remoteDataSource: serviceLocator()),
    )
    // Cubit
    ..registerFactory<FavoritesCubit>(() => FavoritesCubit(serviceLocator()))
    //FavoritesRemoteDataSource
    ..registerFactory<FavoritesRemoteDataSource>(
      () => FavoritesRemoteDataSource(serviceLocator()),
    );
}
