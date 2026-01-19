import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasources/auth_remote_data_source.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/usecases/signup_usecase.dart';
import '../../cubit/signup/signup_cubit.dart';
import 'signup_view.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final repo = AuthRepositoryImpl(AuthRemoteDataSource());

        return SignupCubit(
          signupUseCase: SignupUseCase(repo),
        );
      },
      child: const SignupView(),
    );
  }
}
