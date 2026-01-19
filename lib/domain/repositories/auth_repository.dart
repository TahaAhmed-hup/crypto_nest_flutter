abstract class AuthRepository {
  Future<void> signUp({
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> resetPassword(String email);
  Future<void> verifyOtp({
    required String email,
    required String otp,
  });
  Future<void> resendOtp(String email);

}
