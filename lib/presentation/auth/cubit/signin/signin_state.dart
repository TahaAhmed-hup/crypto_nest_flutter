abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {}

class SigninError extends SigninState {
  final String message;
  SigninError(this.message);
}

class ResetPasswordSuccess extends SigninState {}
