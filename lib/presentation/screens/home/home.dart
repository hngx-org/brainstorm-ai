import 'dart:math';

import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/reusables/automated_qyns.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/glow_logo.dart';
import 'package:ai_brainstorm/common/constants/reusables/text.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/data/models/chat_model.dart';
import 'package:ai_brainstorm/data/models/message_model.dart';
import 'package:ai_brainstorm/presentation/screens/chat_automations/chat_automations.dart';
import 'package:ai_brainstorm/presentation/screens/suscribe_screen/main_suscribe_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constants/route_constant.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  const HomeScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ChatModel model;
  String _greetingText = '';
  List<String> academicQuestions = [
    "What is the significance of the Theory of Relativity in physics?",
    "Discuss the impact of climate change on agriculture.",
    "Explain the concept of artificial intelligence.",
  ];
  
  @override
  void initState() {
    super.initState();
    _updateGreeting();
    model = ChatModel()
      ..addListener(() {
        setState((){});
      });
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      setState(() {
        _greetingText = 'Good Morning';
      });
    } else if (hour >= 12 && hour < 17) {
      setState(() {
        _greetingText = 'Good Afternoon';
      });
    } else {
      setState(() {
        _greetingText = 'Good Evening';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Stack(
      children: [
        const CustomBackground(),
        SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: mediaQuery.width,
            height: mediaQuery.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: _greetingText,
                            fontSize: 22,
                            color: AppColor.white.withOpacity(0.6),
                          ),
                          CustomText(
                            text: widget.name,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white.withOpacity(0.8),
                          )
                        ],
                      ),
                      GlowingLogo(),
                    ],
                  ),
                ),
                30.verticalSpace,
                //recent
                StreamBuilder(
                  stream: model.streamChatTitles(),
                  builder: (context, streamSnapshot) {
                    return FutureBuilder(
                      future: streamSnapshot.data,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!=null && snapshot.data!.isNotEmpty){
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'Recent',
                                      fontSize: 22,
                                      color: AppColor.whiteOpacity8,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        routerConfig.push(RoutesPath.chatHistoryScreen);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.whiteOpacity8),
                                        child: const Icon(
                                          CupertinoIcons.arrow_up_right,
                                          weight: 4,
                                          size: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              20.verticalSpace,
                              Container(
                                height: mediaQuery.width * 0.13,
                                width: mediaQuery.width,
                                child: Container(
                                  width: double.infinity,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: min(3, snapshot.data!.length),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            30.horizontalSpace,
                                            GestureDetector(
                                              onTap: () {
                                                routerConfig.push(
                                                  RoutesPath.chatScreen,
                                                  extra: {
                                                    'chatName': snapshot.data![index]
                                                  }
                                                );
                                              },
                                              child: Container(
                                                // width: mediaQuery.width * 0.7,
                                                // margin: const EdgeInsets.only(right: 20),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40),
                                                      side: BorderSide(
                                                          color: AppColor.white.withOpacity(0.2),
                                                          width: 1)),
                                                  color: AppColor.white.withOpacity(0.2),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: CustomText(
                                                            text:
                                                                snapshot.data![index],
                                                            fontSize: 15)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      }
                    );
                  }
                ),
                20.verticalSpace,
                //automation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Automations',
                        fontSize: 22,
                        color: AppColor.whiteOpacity8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainAutomations()),
                          );
                        },
                        child: GestureDetector(
                          onTap: (){
                            routerConfig.push(RoutesPath.mainAutomations);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.whiteOpacity8),
                            child: const Icon(
                              CupertinoIcons.arrow_up_right,
                              weight: 4,
                              size: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                20.verticalSpace,
                // cards
                SizedBox(
                  height: 170,
                  width: mediaQuery.width,
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: academicQuestions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              30.horizontalSpace,
                              SizedBox(
                                width: mediaQuery.width * 0.7,
                                // margin: const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: (){
                                    routerConfig.push(
                                      RoutesPath.chatScreen,
                                      extra: {
                                        'initialQuery': Message(
                                          sender: Sender.user,
                                          message: academicQuestions[index],
                                          timestamp: DateTime.now()
                                        )
                                      }
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: AppColor.white.withOpacity(0.6),
                                            width: 1)),
                                    color: AppColor.whiteOpacity8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.bookmarks,
                                            color: Colors.black.withOpacity(0.8),
                                            size: 22,
                                          ),
                                          10.verticalSpace,
                                          CustomText(
                                              text: academicQuestions[index],
                                              fontSize: 22,
                                              maxLines: 3,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black.withOpacity(0.8)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                20.verticalSpace,
                //automation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Popular Questions',
                        fontSize: 22,
                        color: AppColor.whiteOpacity8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainAutomations()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.whiteOpacity8),
                          child: const Icon(
                            CupertinoIcons.arrow_up_right,
                            weight: 4,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: AutomatedQuestions(mediaQuery: mediaQuery),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
