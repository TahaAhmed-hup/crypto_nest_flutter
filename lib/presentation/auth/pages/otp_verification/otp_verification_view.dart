import 'package:crypto_nest/presentation/auth/pages/verify_account/verify_acoount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commen/widgets/appbar/app_bar.dart';
import '../../../../commen/widgets/button/basic_app_button.dart';
import '../../../../commen/widgets/otp/custom_otp_keyboard.dart';
import '../../../../commen/widgets/otp/otp_input.dart';
import '../../../../commen/widgets/otp/otp_timer.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/widgets/app_snackbar.dart'; 
import '../../cubit/otp_verification/otp_verification_cubit.dart';
import '../../cubit/otp_verification/otp_verification_state.dart';

class OtpVerificationView extends StatefulWidget {
  final String email;
  const OtpVerificationView({super.key, required this.email});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  String otp = '';

  final GlobalKey<OtpInputState> _otpInputKey = GlobalKey<OtpInputState>();

  void _onKeyboardPress(String key) {
    final otpState = _otpInputKey.currentState;
    if (otpState == null) return;

    if (key == 'delete') {
      otpState.deleteDigit();
    } else {
      if (otpState.currentIndex < otpState.controllers.length) {
        otpState.inputDigit(key);
      }
    }

    setState(() {
      otp = otpState.controllers.map((c) => c.text).join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
      listenWhen: (prev, curr) =>
          curr is OtpVerificationSuccess ||
          curr is OtpVerificationError ||
          curr is OtpVerificationOtpResent,
      listener: (context, state) {
        if (state is OtpVerificationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const VerifyAccountPage(),
              ),
            );
          });
        }

        if (state is OtpVerificationError) {
          AppSnackBar.show(context, message: state.message, isError: true);
        }

        if (state is OtpVerificationOtpResent) {
          AppSnackBar.show(context, message: 'OTP has been resent');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const BasicAppbar(titleText: 'Verification'),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TEXT
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Code have been sent to your email\n',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: widget.email,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 20),

                        /// OTP INPUT
                        Center(
                          child: OtpInput(
                            key: _otpInputKey,
                            onCompleted: (value) {
                              setState(() {
                                otp = value;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// TIMER
                        Center(
                          child: OtpTimer(
                            onResend: () {
                              context
                                  .read<OtpVerificationCubit>()
                                  .resendOtp(widget.email);
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: SizedBox(
                            width: double.infinity,  
                            child: BasicAppButton(
                              title: state is OtpVerificationLoading
                                  ? 'Verifying...'
                                  : 'Verify',
                              isLoading: state is OtpVerificationLoading,
                              onPressed: state is OtpVerificationLoading
                                  ? null
                                  : () {
                                      final currentOtp = _otpInputKey
                                              .currentState?.controllers
                                              .map((c) => c.text)
                                              .join() ??
                                          '';

                                      if (currentOtp.length != 4) {
                                        AppSnackBar.show(
                                          context,
                                          message: 'Please enter the complete OTP',
                                          isError: true,
                                        );
                                        return;
                                      }

                                      context
                                          .read<OtpVerificationCubit>()
                                          .verify(
                                            email: widget.email,
                                            otp: currentOtp,
                                          );
                                    },
                            ),
                          ),
                        ),

                        const SizedBox(height: 40), 
                      ],
                    ),
                  ),
                ),

                CustomOtpKeyboard(onKeyPress: _onKeyboardPress),
              ],
            ),
          ),
        );
      },
    );
  }
}
