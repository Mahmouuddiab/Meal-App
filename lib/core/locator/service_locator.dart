import 'package:get_it/get_it.dart';
import 'package:meal_app/core/secrets/app_secrets.dart';
import 'package:meal_app/features/Home/Data/Datasource/HomeDataSource.dart';
import 'package:meal_app/features/Home/Data/Repository/Repository.dart';
import 'package:meal_app/features/Home/Domain/Repository/Repository.dart';
import 'package:meal_app/features/Home/presentation/Cubit/home_cubit.dart';
import 'package:meal_app/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:meal_app/features/auth/domain/usecases/update_user_profile.dart';
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


  //serviceLocator.registerSingleton<CacheHelper>(CacheHelper());

  initAuth();

  initHome();
}


void initAuth() {
  // Data source
  serviceLocator
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Use-cases
    ..registerLazySingleton(() => UserSignUp(serviceLocator()))
    ..registerLazySingleton(() => UserSignIn(serviceLocator()))
    ..registerLazySingleton(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(() => UpdateUserProfile(repo: serviceLocator()))
    // Bloc
    ..registerFactory(
      () => AuthBloc(
        currentUser: serviceLocator(),
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        updateUser:  serviceLocator()
      ),
    );
}

void initHome() {
  serviceLocator
    // Repository
    ..registerLazySingleton<MealsRepository>(
      () => MealsRepositoryImpl(serviceLocator()),
    )
    // Cubit
    ..registerFactory<HomeCubit>(() => (HomeCubit(serviceLocator())))
    //FavoritesRemoteDataSource
    ..registerLazySingleton<MealsRemoteDataSource>(
      () => MealsRemoteDataSource(serviceLocator()),
    );
}
