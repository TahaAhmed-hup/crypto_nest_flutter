import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) {
    return remote.signUp(email, password);
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) {
    return remote.signIn(email, password);
  }

  @override
  Future<void> resetPassword(String email) {
    return remote.resetPassword(email);
  }
  @override
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) {
    return remote.verifyOtp(email: email, otp: otp);
  }
  @override
  Future<void> resendOtp(String email) {
    return remote.resendOtp(email);
  }
}
