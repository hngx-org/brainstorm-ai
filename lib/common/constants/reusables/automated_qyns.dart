
import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/reusables/text.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class AutomatedQuestions extends StatelessWidget {
  const AutomatedQuestions({
    super.key,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    const projectTopic = '#1 Project topic';
    const novelIdeas = '#2 Novel ideas';
    const experimentalDesign  = '#3 Experimental Design';
    const dataAnalysis  = '#4 Data Analysis';

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  routerConfig.push(RoutesPath.chatScreen, extra: {'automated' : 1});
                },
                child: Container(
                  height: mediaQuery.width * 0.13,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(
                            color: AppColor.white.withOpacity(0.6),
                            width: 1)),
                    color: AppColor.white.withOpacity(0.2),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text:
                              projectTopic,
                              fontSize: 15)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  routerConfig.push(RoutesPath.chatScreen, extra: {'automated' : 2});
                },
                child: Container(
                  height: mediaQuery.width * 0.13,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(
                            color: AppColor.white.withOpacity(0.6),
                            width: 1)),
                    color: AppColor.white.withOpacity(0.2),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text:
                              novelIdeas,
                              fontSize: 15)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  routerConfig.push(RoutesPath.chatScreen, extra: {'automated' : 3});
                },
                child: Container(
                  height: mediaQuery.width * 0.13,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(
                            color: AppColor.white.withOpacity(0.6),
                            width: 1)),
                    color: AppColor.white.withOpacity(0.2),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text:
                              experimentalDesign,
                              fontSize: 15)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  routerConfig.push(RoutesPath.chatScreen, extra: {'automated' : 4});
                },
                child: Container(
                  height: mediaQuery.width * 0.13,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(
                            color: AppColor.white.withOpacity(0.6),
                            width: 1)),
                    color: AppColor.white.withOpacity(0.2),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text:
                              dataAnalysis,
                              fontSize: 15)),
                    ),
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