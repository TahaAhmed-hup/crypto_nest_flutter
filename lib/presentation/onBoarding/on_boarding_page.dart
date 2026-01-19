import 'package:flutter/material.dart';
import 'package:crypto_nest/core/configs/assets/app_images.dart';
import 'package:crypto_nest/core/configs/theme/app_colors.dart';

import 'pages/onboarding_slide.dart';
import 'signup_or_signin.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();
  int index = 0;

  late final List<Widget> pages = const [
    OnboardingSlide(
      imagePath: AppImages.first,
      title: 'Welcome to \nFox',
      highlighted: 'crypto',
    ),
    OnboardingSlide(
      imagePath: AppImages.second,
      title: 'Transaction \nSecurity',
    ),
    OnboardingSlide(
      imagePath: AppImages.third,
      title: 'Fast and reliable \nMarket updated',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goNext() {
    if (index < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _skip();
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignupOrSigninPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (index != pages.length - 1)
            TextButton(
              onPressed: _skip,
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 18, color: AppColors.primary),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) => setState(() => index = value),
              itemBuilder: (context, i) => pages[i],
            ),
          ),

          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: size.height * 0.02,
              ),
              child: Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      pages.length,
                      (i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CustomIndicator(active: index == i),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _goNext,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primary,
                      ),
                      child: Icon(
                        index == pages.length - 1
                            ? Icons.check
                            : Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final bool active;
  const CustomIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active ? AppColors.primary : Colors.grey.shade600,
      ),
      width: active ? 30 : 10,
      height: 10,
    );
  }
}
