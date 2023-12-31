import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/transparent_film.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:ai_brainstorm/data/models/chat_model.dart';
import 'package:ai_brainstorm/data/others/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  final String name;
  const SettingsScreen({super.key, required this.name,});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  int? credit = 0;
  List <String> name = [];

  @override
  void initState() {
    super.initState();
    name = widget.name.split('_');
    name[0] = Utils.capitalizeFirstWord(name[0]);
    if (name.length > 1) {
      name[1] = Utils.capitalizeFirstWord(name[1]);
    }else{
      name.add('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    credit = SharedPreferencesManager.prefs.getInt('credits');

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: Stack(
          children: [
            CustomBackground(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  40.verticalSpace,
                  Text(
                    '${name[0] } ${name[1] }',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  if (credit != null )  20.verticalSpace,
                  if (credit != null ) Text(
                    'Your Credit is $credit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.whiteOpacity8,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 40,),
                  SizedBox( // TODO: only show this widget when the user doesnt already have premium
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TransparentFilm.light(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => routerConfig.push(RoutesPath.mainSuscribeScreen),
                                child: SizedBox(
                                  width: 200,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Upgrade to premium',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: AppColor.whiteOpacity8,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      Text(
                                        'Unlock premium to remove ads and chat with unlimited gpt',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox.square(
                                dimension: 40,
                                child: GestureDetector(
                                  onTap: () => routerConfig.push(RoutesPath.mainSuscribeScreen),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: AppColor.whiteOpacity8
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  SizedBox(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TransparentFilm.dark(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  routerConfig.push(RoutesPath.chatHistoryScreen);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.history, color: AppColor.whiteOpacity8,),
                                      const SizedBox(width: 10,),
                                      Text(
                                        'Chat History',
                                        style: TextStyle(
                                           color: AppColor.whiteOpacity8,
                                          fontSize: 15
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: Colors.white.withOpacity(0.5),),
                              GestureDetector(
                                onTap: (){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Chat history will be deleted'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: (){},
                                      ),
                                    )
                                  ).closed.then((reason){
                                    print(reason);
                                    if(reason != SnackBarClosedReason.action){
                                      ChatModel().deleteAll();
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_forever_outlined, color: AppColor.whiteOpacity8,),
                                      const SizedBox(width: 10,),
                                      Text(
                                        'Delete Chat History',
                                        style: TextStyle(
                                          color: AppColor.whiteOpacity8,
                                          fontSize: 15
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: Colors.white.withOpacity(0.5),),
                              GestureDetector(
                                onTap: () async {
                                  SharedPreferencesManager.prefs.remove('id');
                                  SharedPreferencesManager.prefs.remove('email');
                                  SharedPreferencesManager.prefs.remove('password');
                                  SharedPreferencesManager.prefs.remove('credits');
                                  SharedPreferencesManager.prefs.remove('name');
                                  SharedPreferencesManager.prefs.remove('session');
                                  ChatModel().deleteAll();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Signing out...'),
                                      )
                                  );

                                  await Future.delayed(const Duration(seconds: 3));
                                  routerConfig.push(RoutesPath.landing);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.logout, color: AppColor.whiteOpacity8,),
                                      const SizedBox(width: 10,),
                                      Text(
                                        'Sign out',
                                        style: TextStyle(
                                          color: AppColor.whiteOpacity8,
                                          fontSize: 15
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}