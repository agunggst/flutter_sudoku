import 'package:flutter/material.dart';

class PushButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final String fontFamily;
  final double paddingH;
  final double paddingV;

  const PushButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 24,
    this.fontFamily = "Rufing",
    this.paddingH = 28,
    this.paddingV = 14,
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
        padding: EdgeInsets.symmetric(horizontal: widget.paddingH, vertical: widget.paddingV),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: widget.fontFamily
          ),
        ),
      ),
    );
  }
}
