import '../repositories/auth_repository.dart';

class SigninUseCase {
  final AuthRepository repo;

  SigninUseCase(this.repo);

  Future<void> call({
    required String email,
    required String password,
  }) {
    return repo.signIn(email: email, password: password);
  }
}
