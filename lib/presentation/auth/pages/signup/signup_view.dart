import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commen/widgets/appbar/app_bar.dart';
import '../../../../commen/widgets/button/basic_app_button.dart';
import '../../../../commen/widgets/text/basic_app_label_text.dart';
import '../../../../commen/widgets/text/basic_app_text_field.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/widgets/app_snackbar.dart'; 
import '../../cubit/signup/signup_cubit.dart';
import '../../cubit/signup/signup_state.dart';
import '../signin/signin.dart';
import '../otp_verification/otp_verification_page_wrapper.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Scaffold(
      appBar: const BasicAppbar(titleText: 'Sign up'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<SignupCubit, SignupState>(
            
            listenWhen: (previous, current) =>
                current is SignupSuccess || current is SignupError,
            listener: (context, state) {
              if (state is SignupSuccess) {
             
                AppSnackBar.show(
                  context,
                  message: 'Account created successfully',
                );

             
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          OtpVerificationPageWrapper(email: state.email),
                    ),
                  );
                });
              } else if (state is SignupError) {
             
                AppSnackBar.show(
                  context,
                  message: state.message,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  /// Email
                  const BasicAppLabelText(title: 'Email Address'),
                  const SizedBox(height: 8),
                  BasicTextField(
                    controller: cubit.emailController,
                    hintText: 'Enter your email address',
                  ),

                  const SizedBox(height: 26),

                  /// Password
                  const BasicAppLabelText(title: 'Password'),
                  const SizedBox(height: 8),
                  BasicPasswordField(
                    controller: cubit.passwordController,
                    hintText: 'Enter your password',
                  ),

                  const SizedBox(height: 8),
                  Text(
                    'At least 8 characters with uppercase letters and numbers',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 24),

                  /// Terms & Privacy
                  CheckboxListTile(
                    value: cubit.isTermsAccepted,
                    activeColor: AppColors.primary,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    onChanged: cubit.toggleTerms,
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Accept ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: 'Terms of Use',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // open terms
                              },
                          ),
                          TextSpan(
                            text: ' & ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // open privacy
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Button
                  SizedBox(
                    width: double.infinity,
                    child: BasicAppButton(
                      title:
                          state is SignupLoading ? 'Signing up...' : 'Sign up',
                      isLoading: state is SignupLoading,
                      onPressed: state is SignupLoading ? null : cubit.signUp,
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// Go to Sign in
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: 'Log in',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SigninPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
