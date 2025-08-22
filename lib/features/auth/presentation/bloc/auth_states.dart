import 'package:flutter/cupertino.dart';
import 'package:meal_app/features/auth/domain/entities/user.dart';


 @immutable
 sealed class AuthStates {
  const AuthStates();
}

final class AuthInitial extends AuthStates {}
final class AuthLoading extends AuthStates {}
final class AuthSuccess extends AuthStates {
  final User user;
  const AuthSuccess(this.user);
}
final class AuthFailure extends AuthStates {
  final String message;
  const AuthFailure(this.message);
}

final class AuthUpdateUserSuccess extends AuthStates{
  final User user;
  const AuthUpdateUserSuccess(this.user);
}
final class AuthUpdateUserFailure extends AuthStates{
  final String message;
  const AuthUpdateUserFailure(this.message);
}