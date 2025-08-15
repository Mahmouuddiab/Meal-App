
import 'package:dartz/dartz.dart';
import 'package:meal_app/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

class UpdateUserProfile {

  AuthRepository repo;

  UpdateUserProfile({
    required this.repo,
  });

  Future<Either<Failure, User>>  call({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String imageURL,
  }) async {
    return repo.upadteUserProfile(
      name: name,
      email: email,
      password: password,
      phone: phone,
      imageURL: imageURL
    );
  }
}