import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repo;

  ResetPasswordUseCase(this.repo);

  Future<void> call(String email) {
    return repo.resetPassword(email);
  }
}
