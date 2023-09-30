import 'dart:ui';
import 'package:flutter/material.dart';

class TransparentFilm extends StatelessWidget {
  final Color color;
  final Widget child;
  const TransparentFilm.light({required this.child, super.key})
    : color = Colors.white;
  const TransparentFilm.dark({required this.child, super.key})
    : color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: color.withOpacity(0.1),
            child: child,
          ),
        ),
      ],
    );
  }
}