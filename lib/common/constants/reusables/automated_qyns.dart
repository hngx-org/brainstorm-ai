
import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/reusables/text.dart';
import 'package:flutter/material.dart';

class AutomatedQuestions extends StatelessWidget {
  const AutomatedQuestions({
    super.key,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: mediaQuery.width * 0.13,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(
                          color: AppColor.white.withOpacity(0.6),
                          width: 1)),
                  color: AppColor.white.withOpacity(0.2),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                            text:
                            '#1 Project topic',
                            fontSize: 15)),
                  ),
                ),
              ),
              Container(
                height: mediaQuery.width * 0.13,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(
                          color: AppColor.white.withOpacity(0.6),
                          width: 1)),
                  color: AppColor.white.withOpacity(0.2),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                            text:
                            '#2 Novel Ideas',
                            fontSize: 15)),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: mediaQuery.width * 0.13,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(
                          color: AppColor.white.withOpacity(0.6),
                          width: 1)),
                  color: AppColor.white.withOpacity(0.2),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                            text:
                            '#1 Project topic',
                            fontSize: 15)),
                  ),
                ),
              ),
              Container(
                height: mediaQuery.width * 0.13,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(
                          color: AppColor.white.withOpacity(0.6),
                          width: 1)),
                  color: AppColor.white.withOpacity(0.2),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                            text:
                            '#2 Novel Ideas',
                            fontSize: 15)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}