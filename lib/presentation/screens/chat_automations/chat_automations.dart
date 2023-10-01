import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/chat_automations/automated_chats_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<Widget> stormsList = [
  const AutomatedStorms(),
  const AutomatedStorms(),
  const AutomatedStorms(),
  const AutomatedStorms(),
  const AutomatedStorms(),
];

class MainAutomations extends StatelessWidget {
  const MainAutomations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          const CustomBackground(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                SizedBox(
                  height: 60.h,
                  width: double.infinity,
                ),
                const TopSection(middleText: "Automations"),
                SizedBox(
                  height: 60.h,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          Positioned(
            top: 130.h,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return stormsList[index];
              },
              itemCount: stormsList.length,
            ),
          ),
        ],
      ),
    );
  }
}
