import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repo;

  SignupUseCase(this.repo);

  Future<void> call({
    required String email,
    required String password,
  }) {
    return repo.signUp(email: email, password: password);
  }
}
