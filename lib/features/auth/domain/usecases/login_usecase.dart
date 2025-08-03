import 'package:dartz/dartz.dart';
import 'package:meal_app/core/error/failure.dart';
import 'package:meal_app/core/usecase/usecase.dart';
import 'package:meal_app/features/auth/domain/entities/user.dart';
import 'package:meal_app/features/auth/domain/repository/auth_repository.dart';

class UserSignIn implements UseCase<User,UserSignInParams>{
  final AuthRepository authRepository;
  const UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async{
    return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }

}
class UserSignInParams{
  final String email;
  final String password;
  UserSignInParams({
    required this.email,
    required this.password
  });
}
