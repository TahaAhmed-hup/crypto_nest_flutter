import 'dart:io';
import 'package:flutter/material.dart';

class PortfolioProfileHeader extends StatelessWidget {
  final String name;
  final String? email;
  final String? selfiePath;

  const PortfolioProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.selfiePath,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = selfiePath != null && File(selfiePath!).existsSync();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF26282F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF343640)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF1E2026),
            backgroundImage: hasFile ? FileImage(File(selfiePath!)) : null,
            child: hasFile
                ? null
                : const Icon(Icons.person, color: Colors.white70, size: 30),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email ?? 'No email',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2026),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF343640)),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified, color: Color(0xFF22E07A), size: 16),
                SizedBox(width: 6),
                Text(
                  'Verified',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
