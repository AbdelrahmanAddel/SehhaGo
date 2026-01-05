import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/sign_up_params.dart';
import '../../domain/usecases/user_google_login.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_logout.dart';
import '../../domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserSignUp _userSignUp;
  final UserGoogleLogin _userGoogleLogin;
  final UserLogout _userLogout;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required UserGoogleLogin userGoogleLogin,
    required UserLogout userLogout,
    required CurrentUser currentUser,
  }) : _userLogin = userLogin,
       _userSignUp = userSignUp,
       _userGoogleLogin = userGoogleLogin,
       _userLogout = userLogout,
       _currentUser = currentUser,
       super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        login: (e) async => _onLogin(e, emit),
        signUp: (e) async => _onSignUp(e, emit),
        googleSignIn: (e) async => _onGoogleSignIn(e, emit),
        logout: (e) async => _onLogout(e, emit),
        checkStatus: (e) async => _onCheckStatus(e, emit),
      );
    });
  }

  Future<void> _onLogin(_AuthLogin event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _userLogin(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (l) => emit(AuthState.failure(l.message)),
      (r) => emit(AuthState.authenticated(r)),
    );
  }

  Future<void> _onSignUp(_AuthSignUp event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _userSignUp(params: event.params);
    result.fold(
      (l) => emit(AuthState.failure(l.message)),
      (r) => emit(AuthState.authenticated(r)),
    );
  }

  Future<void> _onGoogleSignIn(
    _AuthGoogleSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _userGoogleLogin();
    result.fold(
      (l) => emit(AuthState.failure(l.message)),
      (r) => emit(AuthState.authenticated(r)),
    );
  }

  Future<void> _onLogout(_AuthLogout event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _userLogout();
    result.fold(
      (l) => emit(AuthState.failure(l.message)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _onCheckStatus(
    _AuthCheckStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _currentUser();
    result.fold(
      (_) => emit(const AuthState.unauthenticated()),
      (r) => emit(AuthState.authenticated(r)),
    );
  }
}
