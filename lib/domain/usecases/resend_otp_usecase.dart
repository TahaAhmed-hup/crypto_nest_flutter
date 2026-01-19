import 'package:crypto_nest/domain/repositories/auth_repository.dart';

class ResendOtpUseCase {
  final AuthRepository repository;

  ResendOtpUseCase(this.repository);

  Future<void> call(String email) {
    return repository.resendOtp(email);
  }
}