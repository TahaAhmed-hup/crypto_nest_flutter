import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/configs/theme/app_colors.dart';

class VerificationUploadCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isUploaded;
  final String? imagePath;
  final VoidCallback? onRemove;

  const VerificationUploadCard({
    super.key,
    required this.label,
    required this.onTap,
    this.isUploaded = false,
    this.imagePath,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 🔴 مهم: لما الصورة موجودة، اقفل onTap بتاع الكارت
      onTap: imagePath == null ? onTap : null,
      child: Stack(
        children: [
          Container(
            height: 125,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isUploaded ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: imagePath != null
                  ? Image.file(
                      File(imagePath!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey.shade400,
                          size: 28,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          label,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          // ❌ زر المسح
          if (imagePath != null && onRemove != null)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque, // ← مهم
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),

          // ✅ Badge Uploaded
          if (imagePath != null)
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Uploaded',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
