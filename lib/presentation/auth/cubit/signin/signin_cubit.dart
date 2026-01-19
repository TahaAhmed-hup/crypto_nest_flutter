import 'package:crypto_nest/presentation/auth/cubit/signin/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/reset_password_usecase.dart';
import '../../../../domain/usecases/signin_usecase.dart';

import '../../../rout_page/pages/portfolio/data/portfolio_storage.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninUseCase signinUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  SigninCubit({
    required this.signinUseCase,
    required this.resetPasswordUseCase,
  }) : super(SigninInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    emit(SigninLoading());
    try {
      await signinUseCase(
        email: emailController.text,
        password: passwordController.text,
      );

      await ProfileStorage.saveEmail(emailController.text);

      emit(SigninSuccess());
    } catch (e) {
      emit(SigninError(e.toString()));
    }
  }

  Future<void> resetPassword() async {
    try {
      await resetPasswordUseCase(emailController.text);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(SigninError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
