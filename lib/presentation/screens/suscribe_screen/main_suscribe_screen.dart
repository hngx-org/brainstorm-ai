import 'package:ai_brainstorm/common/constants/reusables/back_button.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:in_app_payment/in_app_payment.dart';
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
  final pay = HNGPay();

  String paymentValue = '';
  bool isLoading = false;
  String? id = '';

  @override
  void initState() {
    firstRadio = FocusNode();
    secondRadio = FocusNode();
    thirdRadio = FocusNode();
    id = SharedPreferencesManager.prefs.getString('id');
    super.initState();
  }

  @override
  void dispose() {
    firstRadio.dispose();
    secondRadio.dispose();
    thirdRadio.dispose();
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 60.h,
                      width: double.infinity,
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BackButtonWidget(),
                      ],
                    ),
                    Center(
                      child: ListOfText(
                        'Upgrade To \nPremium Plan',
                        35.sp,
                        FontWeight.bold,
                        false,
                      ),
                    ),
                    ListOfText(
                      'Enjoy access to all features of BrainStormAI',
                      18.sp,
                      FontWeight.w300,
                      false,
                    ),
                    const SizedBox(height: 10,),
                    ListOfText(
                      'Ads free  experiences',
                      18.sp,
                      FontWeight.w500,
                      true,
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
                    10.verticalSpace,
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                      thickness: 1.h,
                      height: 30.sp,
                      endIndent: 15.w,
                      indent: 15.w,
                    ),
                    Center(
                      child: ChooseSubsPrice(
                        howLong: 'Weekly',
                        length: '\$5/week',
                        radioValue: 1,
                        radiogroupValue: selectedRadioValue,
                        onChanged: (value) {
                          setState(() {
                            setSelectedRadioValue(value);
                            paymentValue = '5';
                            print(paymentValue);
                          });
                        },
                        getFocus: firstRadio,
                      ),
                    ),
                    Center(
                        child: ChooseSubsPrice(
                      howLong: 'Monthly',
                      length: '\$15/month',
                      radioValue: 2,
                      radiogroupValue: selectedRadioValue,
                      onChanged: (value) {
                        setState(() {
                          setSelectedRadioValue(value);
                          paymentValue = '15';
                          print(paymentValue);
                        });
                      },
                      getFocus: firstRadio,
                    )),
                    Center(
                      child: ChooseSubsPrice(
                        howLong: 'Lifetime',
                        length: '\$100',
                        radioValue: 3,
                        radiogroupValue: selectedRadioValue,
                        onChanged: (value) {
                          setState(() {
                            setSelectedRadioValue(value);
                            paymentValue = '100';
                            print(paymentValue);
                          });
                        },
                        getFocus: thirdRadio,
                      ),
                    ),
                    10.verticalSpace,
                    if (paymentValue != '' ) Center(
                      child: pay.googlePay(context, amountToPay: paymentValue, userID: id!),
                    ),
                    if (isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final double width;
  final double height;
  final double margin;
  final String actionText;
  final Function()? onTap;
  final Color containerColor;
  final Color? color;
  final Color containerTextColor;
  const ActionButton({
    super.key,
    required this.width,
    required this.height,
    required this.actionText,
    this.onTap,
    required this.containerColor,
    required this.containerTextColor,
    required this.margin, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: margin),
            height: height,
            // width: width,
            decoration: BoxDecoration(
              color: color ?? Colors.transparent,
              borderRadius: BorderRadius.circular(40.r),
              // border: Border.all(
              //   color: Colors.white
              // )
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32
                ),
                child: Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: containerTextColor,
                    // color: Colors.white,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
