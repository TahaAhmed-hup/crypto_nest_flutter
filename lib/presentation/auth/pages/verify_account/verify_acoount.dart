import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/verify_account/verify_account_cubit.dart';
import 'verify_account_view.dart';

class VerifyAccountPage extends StatelessWidget {
  const VerifyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyAccountCubit(),
      child: const VerifyAccountView(),
    );
  }
}
