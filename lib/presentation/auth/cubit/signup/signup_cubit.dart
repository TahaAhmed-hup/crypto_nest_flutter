import 'package:crypto_nest/presentation/auth/cubit/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/signup_usecase.dart';

import '../../../rout_page/pages/portfolio/data/portfolio_storage.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;

  SignupCubit({required this.signupUseCase}) : super(SignupInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isTermsAccepted = false;

  void toggleTerms(bool? value) {
    isTermsAccepted = value ?? false;
    emit(SignupInitial());
  }

  Future<void> signUp() async {
    if (!isTermsAccepted) {
      emit(const SignupError('Please accept Terms & Privacy Policy'));
      return;
    }

    final passwordError = validateStrongPassword(passwordController.text);
    if (passwordError != null) {
      emit(SignupError(passwordError));
      return;
    }

    emit(SignupLoading());

    try {
      final email = emailController.text;

      await signupUseCase(
        email: email,
        password: passwordController.text,
      );

      await ProfileStorage.saveEmail(email);

      emit(SignupSuccess(email: email));
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

String? validateStrongPassword(String value) {
  if (value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'Password must be at least 8 characters';
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Include at least one uppercase letter';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Include at least one lowercase letter';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) return 'Include at least one number';
  if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
    return 'Include at least one special character';
  }
  return null;
}
