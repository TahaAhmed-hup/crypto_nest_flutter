import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final SupabaseClient supabase = Supabase.instance.client;

  String _normalizeEmail(String email) => email.trim().toLowerCase();

  String _normalizeOtp(String otp) =>
      otp.trim().replaceAll(RegExp(r'[^0-9]'), '');

  /// ================= SIGN UP =================
  Future<void> signUp(String email, String password) async {
    final cleanEmail = _normalizeEmail(email);

    final res = await supabase.auth.signUp(
      email: cleanEmail,
      password: password,
    );

    if (res.user == null) {
      throw const AuthException('Signup failed');
    }

    /// بعد الـ signup نبعت OTP عبر الـ Edge Function
    await sendOtp(cleanEmail);
  }

  /// ================= SIGN IN =================
  Future<void> signIn(String email, String password) async {
    final cleanEmail = _normalizeEmail(email);

    final res = await supabase.auth.signInWithPassword(
      email: cleanEmail,
      password: password,
    );

    if (res.user == null) {
      throw const AuthException('Login failed');
    }
  }

  /// ================= RESET PASSWORD =================
  Future<void> resetPassword(String email) async {
    final cleanEmail = _normalizeEmail(email);
    await supabase.auth.resetPasswordForEmail(cleanEmail);
  }

  /// ================= SEND OTP =================
  Future<void> sendOtp(String email) async {
    final cleanEmail = _normalizeEmail(email);

    final res = await supabase.functions.invoke(
      'send-otp',
      body: {'email': cleanEmail},
    );

    final data = res.data;

    if (data == null) {
      throw Exception('No response from server');
    }

    if (data is Map) {
      if (data['success'] == true) return;

      // لو الـ function بترجع error
      final msg = data['error']?.toString() ?? 'Failed to send OTP';
      throw Exception(msg);
    }

    throw Exception('Unexpected response format');
  }

  /// ================= VERIFY OTP =================
  /// بدل ما نعمل select/update على table (RLS)، نعمل verify من Edge Function
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final cleanEmail = _normalizeEmail(email);
    final cleanOtp = _normalizeOtp(otp);

    if (cleanOtp.length != 4) {
      throw const AuthException('OTP must be 4 digits');
    }

    final res = await supabase.functions.invoke(
      'verify-otp',
      body: {
        'email': cleanEmail,
        'otp': cleanOtp,
      },
    );

    final data = res.data;

    if (data == null) {
      throw const AuthException('No response from server');
    }

    if (data is Map) {
      if (data['success'] == true) return;

      // سبب فشل اختياري لو function رجعته
      final reason = data['reason']?.toString();
      if (reason == 'invalid_or_expired') {
        throw const AuthException('Invalid or expired OTP');
      }

      final msg = data['error']?.toString() ?? 'Invalid or expired OTP';
      throw AuthException(msg);
    }

    throw const AuthException('Unexpected response format');
  }

  /// ================= RESEND OTP =================
  /// الأفضل تخلي resend كله في send-otp (يبطل القديم ويبعت الجديد)
  /// فهنا هننادي sendOtp مباشرة.
  Future<void> resendOtp(String email) async {
    final cleanEmail = _normalizeEmail(email);
    await sendOtp(cleanEmail);
  }
}
