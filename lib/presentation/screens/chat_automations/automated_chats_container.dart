import 'package:ai_brainstorm/data/models/message_model.dart';
import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/suscribe_screen/main_suscribe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutomatedStorms extends StatefulWidget {
  final String text;
  const AutomatedStorms({super.key, required this.text});

  @override
  State<AutomatedStorms> createState() => _AutomatedStormsState();
}

class _AutomatedStormsState extends State<AutomatedStorms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.r),
      padding: EdgeInsets.all(15.sp),
      // height: 250.h,
      width: 370.w,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon(
          //   Icons.storage_outlined,
          //   size: 28.sp,
          //   color: Colors.black,
          // ),
          10.verticalSpace,
          Text(
            'Ask BrainStorm-Ai',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(.8),
              decoration: TextDecoration.none,
            ),
          ),
          20.verticalSpace,
          Text(
            widget.text ?? '',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(.8),
              decoration: TextDecoration.none,
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                height: 50.h,
                width: 300.w,
                actionText: 'Generate',
                margin: 5.h,
                color: Colors.white.withOpacity(0.5),
                containerTextColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(
                      initialQuery: Message(
                        sender: Sender.user,
                        message: widget.text,
                        timestamp: DateTime.now()
                      ),
                    )),
                  );
                },
                containerColor: Colors.black,
              ),
            ],
          )
        ],
      ),
    );
  }
}
