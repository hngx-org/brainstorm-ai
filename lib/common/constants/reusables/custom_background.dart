import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.bgImage), fit: BoxFit.cover)),
    );
  }
}