import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final String? route;

  const BackButtonWidget({
    super.key, this.route,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 40,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppColor.whiteOpacity6),
        child: Center(
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            iconSize: 24,
            onPressed: () {
              route ?? routerConfig.pop();
            },
          ),
        ),
      ),
    );
  }
}