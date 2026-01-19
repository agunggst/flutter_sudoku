import 'package:flutter/material.dart';

class PushButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final String fontFamily;
  final double paddingH;
  final double paddingV;
  final bool enabled;
  final String? disabledTooltip;

  const PushButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 24,
    this.fontFamily = "Rufing",
    this.paddingH = 28,
    this.paddingV = 14,
    this.enabled = true,
    this.disabledTooltip,
  });

  @override
  State<PushButton> createState() => _PushButtonState();
}

class _PushButtonState extends State<PushButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = !widget.enabled;

    Widget button = GestureDetector(
      onTapDown: isDisabled
          ? null
          : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled
          ? null
          : (_) {
              setState(() => _isPressed = false);
              widget.onPressed();
            },
      onTapCancel: isDisabled
          ? null
          : () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(
          0,
          _isPressed ? 4 : 0,
          0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widget.paddingH,
          vertical: widget.paddingV,
        ),
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey.shade400
              : const Color(0xFFFF4B2B),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isDisabled
              ? []
              : [
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
            color: isDisabled ? Colors.grey.shade700 : Colors.white,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: widget.fontFamily,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );

    if (isDisabled && widget.disabledTooltip != null) {
      return Tooltip(
        message: widget.disabledTooltip!,
        child: button,
      );
    }

    return button;
  }
}