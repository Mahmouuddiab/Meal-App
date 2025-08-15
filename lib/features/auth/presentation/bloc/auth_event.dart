part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
final class AuthSignUp extends AuthEvent{
  final String email;
  final String name;
  final String password;
  final String phone;
  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
}

final class AuthSignIn extends AuthEvent{
  final String email;
  final String password;
  AuthSignIn({required this.email,required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent{

}

class AuthUpdateUserData extends AuthEvent{

  final String email;
  final String name;
  final String password;
  final String phone;
  final String imageURL;
  AuthUpdateUserData({
  required this.email,
  required this.password,
  required this.name,
  required this.phone,
  required this.imageURL,
  });
}
