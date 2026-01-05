part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = _AuthLogin;

  const factory AuthEvent.signUp({required SignUpParams params}) = _AuthSignUp;

  const factory AuthEvent.googleSignIn() = _AuthGoogleSignIn;

  const factory AuthEvent.logout() = _AuthLogout;

  const factory AuthEvent.checkStatus() = _AuthCheckStatus;
}
