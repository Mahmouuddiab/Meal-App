import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/usecase/usecase.dart';
import 'package:meal_app/features/auth/domain/usecases/current_user.dart';
import 'package:meal_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:meal_app/features/auth/domain/usecases/register_usecse.dart';
import 'package:meal_app/features/auth/domain/usecases/update_user_profile.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_states.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final UpdateUserProfile _updateUser;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required UpdateUserProfile updateUser,
    })
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _updateUser = updateUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthUpdateUserData>(_onUpdateUserData);
  }
  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthStates> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
          (l) => emit(AuthFailure(l.message)),
          (r) {
        print(r.email);
        emit(AuthSuccess(r));
      },
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthStates> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        name: event.name, 
        password: event.password,
        phone: event.phone
      ));
    res.fold(
            (l) => emit(AuthFailure(l.message)), (user) => emit(AuthSuccess(user)));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthStates> emit) async {
    emit(AuthLoading());
    final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    res.fold(
            (l) => emit(AuthFailure(l.message)), (user) => emit(AuthSuccess(user)));
  }

  void _onUpdateUserData(AuthUpdateUserData event, Emitter<AuthStates> emit) async{
    emit(AuthLoading());
    final res = await _updateUser(
      name: event.name,
      email: event.email,
      password: event.password,
      phone: event.phone,
      imageURL: event.imageURL
    );
    
    res.fold(
      (l) => emit(AuthUpdateUserFailure(l.message)), 
      (user) => emit(AuthUpdateUserSuccess(user))
    );
    
    
  }
}
