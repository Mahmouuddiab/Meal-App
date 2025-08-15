import 'package:dartz/dartz.dart';
import 'package:meal_app/core/error/failure.dart';
import 'package:meal_app/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String phone
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, User>> upadteUserProfile({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String imageURL,
  });
}
