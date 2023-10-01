import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/suscribe_screen/choose_subscribeprice.dart';
import 'package:ai_brainstorm/presentation/screens/suscribe_screen/subscribe_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainSuscribeScreen extends StatefulWidget {
  const MainSuscribeScreen({super.key});

  @override
  State<MainSuscribeScreen> createState() => _MainSuscribeScreenState();
}

class _MainSuscribeScreenState extends State<MainSuscribeScreen> {
  late FocusNode firstRadio;
  late FocusNode secondRadio;
  late FocusNode thirdRadio;

  @override
  void initState() {
    firstRadio = FocusNode();
    secondRadio = FocusNode();
    thirdRadio = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    firstRadio.dispose();
    secondRadio.dispose();
    thirdRadio.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: double.infinity,
                  ),
                  const TopSection(
                    middleText: '',
                  ),
                  Center(
                      child: ListOfText(
                    'Upgrade To \nPremium Plan',
                    35.sp,
                    FontWeight.bold,
                    false,
                  )),
                  Center(
                    child: ListOfText(
                      'Enjoy access to all features of BrainStormAI',
                      18.sp,
                      FontWeight.w500,
                      false,
                    ),
                  ),
                  Center(
                    child: ListOfText(
                      'Ads free  experiences',
                      18.sp,
                      FontWeight.w500,
                      true,
                    ),
                  ),
                  Center(
                    child: ListOfText(
                      'Unlimited questions and answers',
                      18.sp,
                      FontWeight.w500,
                      true,
                    ),
                  ),
                  Center(
                    child: ListOfText(
                      'High word limit question and answer',
                      18.sp,
                      FontWeight.w500,
                      true,
                    ),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.5),
                    thickness: 1.h,
                    height: 30.sp,
                    endIndent: 15.w,
                    indent: 15.w,
                  ),
                  Center(
                    child: ChooseSubsPrice(
                      howLong: 'Weekly \n\$5',
                      length: '/week',
                      radioValue: 1,
                      radiogroupValue: selectedRadioValue,
                      onChanged: (value) {
                        setState(() {
                          setSelectedRadioValue(value);
                        });
                      },
                      getFocus: firstRadio,
                    ),
                  ),
                  Center(
                      child: ChooseSubsPrice(
                    howLong: 'Monthly \n\$15',
                    length: '/month',
                    radioValue: 2,
                    radiogroupValue: selectedRadioValue,
                    onChanged: (value) {
                      setState(() {
                        setSelectedRadioValue(value);
                      });
                    },
                    getFocus: firstRadio,
                  )),
                  Center(
                    child: ChooseSubsPrice(
                      howLong: 'Lifetime \n\$100',
                      length: '',
                      radioValue: 3,
                      radiogroupValue: selectedRadioValue,
                      onChanged: (value) {
                        setState(() {
                          setSelectedRadioValue(value);
                        });
                      },
                      getFocus: thirdRadio,
                    ),
                  ),
                  Center(
                    child: ActionButton(
                      margin: 30.h,
                      height: 70.h,
                      width: 370.w,
                      containerTextColor: Colors.black,
                      actionText: 'Continue',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatScreen(automated: 0,)),
                        );
                      },
                      containerColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final double width;
  final double height;
  final double margin;
  final String actionText;
  void Function()? onTap;
  final Color containerColor;
  final Color containerTextColor;
  ActionButton({
    super.key,
    required this.width,
    required this.height,
    required this.actionText,
    this.onTap,
    required this.containerColor,
    required this.containerTextColor,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: margin),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Center(
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 22.sp,
              color: containerTextColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}