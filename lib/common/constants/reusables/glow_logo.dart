import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:flutter/material.dart';

class GlowingLogo extends StatefulWidget {
  @override
  _GlowingLogoState createState() => _GlowingLogoState();
}

class _GlowingLogoState extends State<GlowingLogo> {
  double _opacity = 1.0;
  ValueNotifier<bool> _blinkNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();

    // Start the blinking animation
    _startBlinkingAnimation();
  }

  void _startBlinkingAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      // Toggle the blinking state
      _blinkNotifier.value = !_blinkNotifier.value;
      // Trigger the animation again
      _startBlinkingAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _blinkNotifier,
      builder: (context, isBlinking, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 900), // Adjust blinking speed
          opacity: isBlinking ? 1.0 : 0.4,
          child: child,
        );
      },
      child: Image.asset(
        Assets.logo,
        height: 60,
      ),
    );
  }

  @override
  void dispose() {
    _blinkNotifier.dispose();
    super.dispose();
  }
}
