import 'package:dartz/dartz.dart';
import 'package:meal_app/core/error/exceptions.dart';
import 'package:meal_app/core/error/failure.dart';
import 'package:meal_app/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:meal_app/features/auth/domain/entities/user.dart';
import 'package:meal_app/features/auth/domain/repository/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository{
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> currentUser()async{
    try{
      final user = await authRemoteDataSource.getCurrentUserData();
      if(user == null)
      {
        return left(Failure("User not logged in"));
      }
      return right(user);
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password})async{
    try{
      final result= await authRemoteDataSource.loginWithEmailPassword(email: email, password: password);
      return right(result.toEntity());
    }catch(e){
      return left(Failure(e.toString())) ;
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name, 
    required String email, 
    required String password , 
    required String phone
  })async{
    try{
      final result= await authRemoteDataSource.signUpWithEmailPassword(name: name, email: email, password: password, phone:phone );
      return right(result);
    }catch(e){
      return left(Failure(e.toString())) ;
    }
  }
  
  @override
  Future<Either<Failure, User>> upadteUserProfile({
   required String name,
   required String email, 
   required String password,
   required String phone, 
   required  String imageURL
  }) async {
    try{
      final userModel = await authRemoteDataSource.updateUserProfile(
        name:  name,
        email: email,
        password: password,
        phone: phone,
        imageURL: imageURL,
      );

      return Right(userModel.toEntity());
    } on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }

  }
  


}