import 'dart:ui';
import 'package:flutter/material.dart';

class TransparentFilm extends StatelessWidget {
  final Color color;
  final Widget child;
  final double opacity;
  const TransparentFilm.light({required this.child, this.opacity=0.1, super.key})
    : color = Colors.white;
  const TransparentFilm.dark({required this.child, this.opacity=0.1, super.key})
    : color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: color.withOpacity(opacity),
            child: child,
          ),
        ),
      ],
    );
  }
}