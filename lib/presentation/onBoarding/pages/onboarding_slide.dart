import 'package:flutter/material.dart';
import 'package:crypto_nest/core/configs/theme/app_colors.dart';

class OnboardingSlide extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? highlighted; 

  const OnboardingSlide({
    super.key,
    required this.imagePath,
    required this.title,
    this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final topSpace = size.height * 0.02;
    final imageHeight = size.height * 0.42; 
    final titleSize = size.width < 360 ? 30.0 : 36.0;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: topSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: highlighted == null
                  ? Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: titleSize,
                        height: 1.1,
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: titleSize,
                          height: 1.1,
                        ),
                        children: [
                          TextSpan(text: title),
                          TextSpan(
                            text: highlighted,
                            style: const TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
