import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/suscribe_screen/main_suscribe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutomatedStorms extends StatefulWidget {
  const AutomatedStorms({super.key});

  @override
  State<AutomatedStorms> createState() => _AutomatedStormsState();
}

class _AutomatedStormsState extends State<AutomatedStorms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.r),
      padding: EdgeInsets.all(15.sp),
      height: 250.h,
      width: 370.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.storage_outlined,
            size: 28.sp,
            color: Colors.black,
          ),
          Text(
            'Want some recipe for break...',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            'Lorem ipsum is placeholder text commonly used in the graohic, print, and publishing industries for prev...',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          Center(
            child: ActionButton(
              height: 50.h,
              width: 300.w,
              actionText: 'Generate',
              margin: 5.h,
              containerTextColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
              containerColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
