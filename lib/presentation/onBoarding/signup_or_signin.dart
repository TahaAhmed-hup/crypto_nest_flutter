import 'package:crypto_nest/core/configs/assets/app_images.dart';
import 'package:crypto_nest/core/configs/theme/app_colors.dart';
import 'package:crypto_nest/presentation/auth/pages/signup/signup.dart';
import 'package:flutter/material.dart';

import '../../commen/widgets/button/basic_app_button.dart';
import '../auth/pages/signin/signin.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isSmall = size.width < 360;

   
    final titleFont = isSmall ? 30.0 : 35.0;
    final imageHeight = size.height * (isSmall ? 0.38 : 0.42);

    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: Image.asset(
                  AppImages.auth,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Fast and Flexible \nTrading',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: titleFont,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupPage(),
                          ),
                        );
                      },
                      title: 'Sign Up',
                      backgroundColor: Colors.black,
                      textColor: AppColors.primary,
                      borderColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SigninPage(),
                          ),
                        );
                      },
                      title: 'Sign in',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
