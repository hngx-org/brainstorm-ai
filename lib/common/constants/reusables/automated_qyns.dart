
import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/reusables/text.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/data/models/message_model.dart';
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

    const pTPrompt = 'Give me a project topic for any field';
    const nIPrompt = 'I need novel ideas';
    const eDPrompt  = 'I want some Experimental Design';
    const dAPrompt  = 'What do you know about Data Analysis';

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  routerConfig.push(
                    RoutesPath.chatScreen,
                    extra: {
                      'initialQuery' : Message(
                        sender: Sender.user,
                        message: pTPrompt,
                        timestamp: DateTime.now()
                      )
                    }
                  );
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
                  routerConfig.push(
                    RoutesPath.chatScreen,
                    extra: {
                      'initialQuery' : Message(
                        sender: Sender.user,
                        message: nIPrompt,
                        timestamp: DateTime.now()
                      )
                    }
                  );
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
                  routerConfig.push(
                    RoutesPath.chatScreen,
                    extra: {
                      'initialQuery' : Message(
                        sender: Sender.user,
                        message: eDPrompt,
                        timestamp: DateTime.now()
                      )
                    }
                  );
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
                  routerConfig.push(
                    RoutesPath.chatScreen,
                    extra: {
                      'initialQuery' : Message(
                        sender: Sender.user,
                        message: dAPrompt,
                        timestamp: DateTime.now()
                      )
                    }
                  );
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