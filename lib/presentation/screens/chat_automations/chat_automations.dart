import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/chat_automations/automated_chats_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<Widget> stormsList = [
  const AutomatedStorms(text: 'What is the significance of the Theory of Relativity in physics?',),
  const AutomatedStorms(text: 'Discuss the impact of climate change on agriculture.',),
  const AutomatedStorms(text: 'Explain the concept of artificial intelligence.',),
  const AutomatedStorms(text: 'What is Neutons Theory',),
];

class MainAutomations extends StatelessWidget {
  const MainAutomations({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              40.verticalSpace,
              const TopSection(middleText: "Automations"),
              // 60.verticalSpace,
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return stormsList[index];
                  },
                  itemCount: stormsList.length,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
