import 'package:crypto_nest/domain/usecases/resend_otp_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/verify_otp_usecase.dart';
import 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  OtpVerificationCubit({
    required this.verifyOtpUseCase,
    required this.resendOtpUseCase,
  }) : super(OtpVerificationInitial());

  Future<void> verify({
  required String email,
  required String otp,
}) async {
  emit(OtpVerificationLoading());
  try {
    await verifyOtpUseCase(email: email, otp: otp);
    emit(OtpVerificationSuccess());
  } catch (_) {
    emit(OtpVerificationError('Invalid or expired OTP'));
  }
}

Future<void> resendOtp(String email) async {
  emit(OtpVerificationLoading());
  try {
    await resendOtpUseCase(email);
    emit(OtpVerificationOtpResent());
  } catch (_) {
    emit(OtpVerificationError('Failed to resend OTP'));
  }
}

}
