abstract class VerifyAccountState {}

class VerifyAccountInitial extends VerifyAccountState {}

class VerifyAccountChanged extends VerifyAccountState {}

class VerifyAccountError extends VerifyAccountState {
  final String message;
  VerifyAccountError(this.message);
}

class VerifyAccountSuccess extends VerifyAccountState {
  final String country;
  final String document;

  VerifyAccountSuccess({
    required this.country,
    required this.document,
  });
}
