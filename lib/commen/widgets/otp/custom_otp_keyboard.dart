import 'package:flutter/material.dart';
import '../../../core/configs/theme/app_colors.dart';

class CustomOtpKeyboard extends StatelessWidget {
  final Function(String) onKeyPress; // "1" .. "9", "0", أو "delete"

  const CustomOtpKeyboard({
    super.key,
    required this.onKeyPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 6,
        crossAxisSpacing: 15,
        childAspectRatio: 1.6, // يخلي الأزرار مستطيلة شوية زي الصورة
        children: [
          _buildNumberKey('1', ''),
          _buildNumberKey('2', 'ABC'),
          _buildNumberKey('3', 'DEF'),
          _buildNumberKey('4', 'GHI'),
          _buildNumberKey('5', 'JKL'),
          _buildNumberKey('6', 'MNO'),
          _buildNumberKey('7', 'PQRS'),
          _buildNumberKey('8', 'TUV'),
          _buildNumberKey('9', 'WXYZ'),
          _buildEmptyKey(), // مكان فاضي بدل +*#
          _buildNumberKey('0', ''),
          _buildDeleteKey(),
        ],
      ),
    );
  }

  Widget _buildNumberKey(String number, String letters) {
    return GestureDetector(
      onTap: () => onKeyPress(number),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.keyboardKey, 
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (letters.isNotEmpty)
              Text(
                letters,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyKey() {
    return const SizedBox.shrink(); // مكان فاضي بدل +*#
  }

  Widget _buildDeleteKey() {
    return GestureDetector(
      onTap: () => onKeyPress('delete'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.backspace_outlined,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}