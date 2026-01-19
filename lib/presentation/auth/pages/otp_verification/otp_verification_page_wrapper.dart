import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasources/auth_remote_data_source.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/usecases/resend_otp_usecase.dart';
import '../../../../domain/usecases/verify_otp_usecase.dart';
import '../../cubit/otp_verification/otp_verification_cubit.dart';
import 'otp_verification_view.dart';

class OtpVerificationPageWrapper extends StatelessWidget {
  final String email;

  const OtpVerificationPageWrapper({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final repo = AuthRepositoryImpl(AuthRemoteDataSource());

        return OtpVerificationCubit(
          verifyOtpUseCase: VerifyOtpUseCase(repo),
          resendOtpUseCase: ResendOtpUseCase(repo),
        );
      },
      child: OtpVerificationView(email: email),
    );
  }
}
