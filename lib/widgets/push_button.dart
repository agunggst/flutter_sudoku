import 'package:flutter/material.dart';

class PushButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const PushButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<PushButton> createState() => _PushButtonState();
}

class _PushButtonState extends State<PushButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(
          0,
          _isPressed ? 4 : 0,
          0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFF4B2B),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC1331E),
              offset: Offset(0, _isPressed ? 2 : 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
