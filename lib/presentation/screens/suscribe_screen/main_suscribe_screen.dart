import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/suscribe_screen/choose_subscribeprice.dart';
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 30.h),
                        height: 70.h,
                        width: 370.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

Text myContainerText(
  String myText,
  FontWeight myweight,
  double textSixe,
) {
  return Text(
    myText,
    textAlign: TextAlign.end,
    style: TextStyle(
      fontWeight: myweight,
      color: Colors.black,
      fontSize: textSixe,
    ),
  );
}

class ListOfText extends StatelessWidget {
  final String myText;
  final double textSixe;
  Color textColor;
  final FontWeight myweight;
  final bool showMark;
  ListOfText(this.myText, this.textSixe, this.myweight, this.showMark,
      [this.textColor = Colors.white]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: showMark
          ? EdgeInsets.only(
              top: 8.sp,
              left: 35.sp,
            )
          : EdgeInsets.only(top: 20.sp),
      child: Row(
        mainAxisAlignment:
            showMark ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          showMark
              ? Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 22.sp,
                )
              : const SizedBox(),
          Text(
            myText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: myweight,
              color: Colors.white,
              fontSize: textSixe,
            ),
          ),
        ],
      ),
    );
  }
}
