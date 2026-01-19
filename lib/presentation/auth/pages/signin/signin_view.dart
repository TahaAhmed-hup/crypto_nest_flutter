import 'package:crypto_nest/presentation/rout_page/pages/root_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commen/widgets/appbar/app_bar.dart';
import '../../../../commen/widgets/button/basic_app_button.dart';
import '../../../../commen/widgets/text/basic_app_label_text.dart';
import '../../../../commen/widgets/text/basic_app_text_field.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/widgets/app_snackbar.dart'; 
import '../../cubit/signin/signin_cubit.dart';
import '../../cubit/signin/signin_state.dart';
import '../signup/signup.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SigninCubit>();

    return Scaffold(
      appBar: const BasicAppbar(
        titleText: 'Log in',
        leadingIcon: Icons.arrow_back_ios,
      ),
      body: SafeArea(
        child: BlocListener<SigninCubit, SigninState>(
          listenWhen: (previous, current) =>
              current is SigninSuccess ||
              current is SigninError ||
              current is ResetPasswordSuccess,
          listener: (context, state) {
            if (state is SigninSuccess) {
              AppSnackBar.show(
                context,
                message: 'Logged in successfully',
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const RootPage()),
                );
              });
            } else if (state is ResetPasswordSuccess) {
  
              AppSnackBar.show(
                context,
                message: 'Password reset link sent',
              );
            } else if (state is SigninError) {

              AppSnackBar.show(
                context,
                message: state.message,
                isError: true,
              );
            }
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

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

                const SizedBox(height: 16),

                /// Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      text: 'Forgot password?',
                      style: const TextStyle(color: AppColors.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = cubit.resetPassword,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 50),

                BlocBuilder<SigninCubit, SigninState>(
                  buildWhen: (previous, current) =>
                      current is SigninLoading || previous is SigninLoading,
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: BasicAppButton(
                        title: state is SigninLoading
                            ? 'Logging in...'
                            : 'Log in',
                        isLoading: state is SigninLoading,
                        onPressed:
                            state is SigninLoading ? null : cubit.signIn,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 60),

                /// Switch to Signup
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "New to Foxcrypto? ",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextSpan(
                          text: "Create an account",
                          style: const TextStyle(color: AppColors.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignupPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
