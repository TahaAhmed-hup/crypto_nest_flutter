import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/configs/theme/app_colors.dart';

class OtpTimer extends StatefulWidget {
  final VoidCallback onResend;
  final int initialSeconds;

  const OtpTimer({
    super.key,
    required this.onResend,
    this.initialSeconds = 30,
  });

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // إلغاء أي تايمر قديم
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        if (mounted) setState(() {}); // تحديث الـ UI لإظهار Resend
      } else {
        if (mounted) {
          setState(() {
            _remainingSeconds--;
          });
        }
      }
    });
  }

  void _handleResend() {
    widget.onResend(); // استدعاء الدالة اللي هتعيد إرسال الكود
    setState(() {
      _remainingSeconds = widget.initialSeconds;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // التايمر دائمًا مرئي، يتوقف عند 00:00
        Text(
          '00:${_remainingSeconds.toString().padLeft(2, '0')}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        // إذا خلص التايمر (عند 0)، نعرض "Resend Code" تحت التايمر
        if (_remainingSeconds <= 0)
          GestureDetector(
            onTap: _handleResend,
            child: const Text(
              'Resend Code',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none, // عشان ما يبقاش في خط تحت
              ),
            ),
          ),
      ],
    );
  }
}