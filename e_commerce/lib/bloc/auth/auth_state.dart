abstract class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class LoginFailureState extends AuthState {
  final String errorMsg;

  LoginFailureState({required this.errorMsg});
}

class RegisterFailureState extends AuthState {
  final String errorMsg;

  RegisterFailureState({required this.errorMsg});
}
