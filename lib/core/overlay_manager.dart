import 'package:flutter/material.dart';

class OverlayManager {
  static final OverlayManager _instance = OverlayManager._internal();
  factory OverlayManager() => _instance;

  OverlayManager._internal();

  OverlayEntry? _overlayEntry;

  void showOverlay(BuildContext context, Widget overlayWidget) {
    if (_overlayEntry != null) return;

    final overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => overlayWidget,
    );

    overlayState.insert(_overlayEntry!);
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
