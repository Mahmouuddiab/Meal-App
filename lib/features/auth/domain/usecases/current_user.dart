import 'package:dartz/dartz.dart';
import 'package:meal_app/core/error/failure.dart';
import 'package:meal_app/core/usecase/usecase.dart';
import 'package:meal_app/features/auth/domain/entities/user.dart';
import 'package:meal_app/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User,NoParams>{

  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  Future<Either<Failure,User>> call(NoParams params)async{
    return await authRepository.currentUser();
  }
}
