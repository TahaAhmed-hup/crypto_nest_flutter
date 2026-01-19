import 'package:crypto_nest/commen/widgets/appbar/app_bar.dart';
import 'package:crypto_nest/commen/widgets/button/basic_app_button.dart';
import 'package:crypto_nest/presentation/rout_page/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/configs/assets/app_images.dart';
import '../../cubit/document_verification/document_verification_cubit.dart';

class FinishVerificationView extends StatelessWidget {
  const FinishVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isSmall = size.height < 700;

    final verticalPad = isSmall ? 30.0 : 75.0;

    final imageHeight = size.height * (isSmall ? 0.28 : 0.32);

    return Scaffold(
      appBar: const BasicAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: verticalPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Image.asset(AppImages.verified, fit: BoxFit.contain),
                ),
                const SizedBox(height: 20),
                Text(
                  'You’re verified',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmall ? 22 : 26,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'You have been verified your information \ncompletely. Let’s make transactions!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmall ? 14 : 16,
                    color: Colors.grey.shade400,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: isSmall ? 28 : 55),
                BasicAppButton(
                  title: 'Back to Home',
                  width: double.infinity,
                  onPressed: () {
                    context.read<DocumentVerificationCubit>().reset();

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const RootPage()),
                        (route) => false,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
