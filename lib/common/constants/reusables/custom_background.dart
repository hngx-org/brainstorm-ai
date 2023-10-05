import 'dart:ui';

import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.aurora), fit: BoxFit.cover
            )
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0),
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.4,
            child: Container(
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}