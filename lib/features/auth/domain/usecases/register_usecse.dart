import 'package:dartz/dartz.dart';
import 'package:meal_app/core/error/failure.dart';
import 'package:meal_app/core/usecase/usecase.dart';
import 'package:meal_app/features/auth/domain/entities/user.dart';
import 'package:meal_app/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  final String phone;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
}
