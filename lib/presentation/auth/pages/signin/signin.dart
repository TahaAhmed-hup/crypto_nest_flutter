import 'package:crypto_nest/data/datasources/auth_remote_data_source.dart';
import 'package:crypto_nest/data/repositories/auth_repository_impl.dart';
import 'package:crypto_nest/domain/usecases/reset_password_usecase.dart';
import 'package:crypto_nest/domain/usecases/signin_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/signin/signin_cubit.dart';
import 'signin_view.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final repo = AuthRepositoryImpl(AuthRemoteDataSource());

        return SigninCubit(
          signinUseCase: SigninUseCase(repo),
          resetPasswordUseCase: ResetPasswordUseCase(repo),
        );
      },
      child: const SigninView(),
    );
  }
}
