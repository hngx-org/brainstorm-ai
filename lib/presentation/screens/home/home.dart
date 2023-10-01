import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/reusables/automated_qyns.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/glow_logo.dart';
import 'package:ai_brainstorm/common/constants/reusables/text.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/presentation/screens/chat_automations/chat_automations.dart';
import 'package:ai_brainstorm/presentation/screens/suscribe_screen/main_suscribe_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constants/route_constant.dart';

class HomeScreen extends StatefulWidget {
  final String firstName;
  const HomeScreen({Key? key, required this.firstName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                20.verticalSpace,
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
                            text: widget.firstName,
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
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.whiteOpacity8),
                        child: const Icon(
                          CupertinoIcons.arrow_up_right,
                          weight: 4,
                          size: 16,
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
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              routerConfig.push(RoutesPath.chatScreen);
                            },
                            child: Container(
                              width: mediaQuery.width * 0.7,
                              margin: const EdgeInsets.only(right: 20),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    side: BorderSide(
                                        color: AppColor.white.withOpacity(0.2),
                                        width: 1)),
                                color: AppColor.white.withOpacity(0.2),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          text:
                                              'testing test me and my might oh lord',
                                          fontSize: 15)),
                                ),
                              ),
                            ),
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
                Container(
                  height: mediaQuery.height * 0.2,
                  width: mediaQuery.width,
                  child: Container(
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: academicQuestions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: mediaQuery.width * 0.7,
                            margin: const EdgeInsets.only(right: 20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: AppColor.white.withOpacity(0.6),
                                      width: 1)),
                              color: AppColor.whiteOpacity8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
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
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.8)),
                                  ],
                                ),
                              ),
                            ),
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
