import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/home/home.dart';
import 'package:ai_brainstorm/presentation/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  const NavigationScreen({Key? key, required this.firstName, required this.lastName}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(
        firstName: widget.firstName,
      ),
      ChatScreen(automated: 0,),
      SettingsScreen(firstname: widget.firstName, lastname: widget.lastName,),
    ];
    setState(() {
      _isChatScreenVisible = false;
    });
  }

  bool _isChatScreenVisible = false;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _isChatScreenVisible = index == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          Positioned(
            bottom: 20,
            child: !_isChatScreenVisible ? Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.greyColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.home_filled),
                    color: _currentIndex == 0
                        ? Colors.white
                        : Colors.white.withOpacity(0.8),
                    iconSize: 30,
                    onPressed: () {
                      _onItemTapped(0);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      color: _currentIndex == 0
                          ? Colors.black
                          : Colors.black.withOpacity(0.8),
                      iconSize: 30,
                      onPressed: () {
                        routerConfig.push(RoutesPath.chatScreen);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: _currentIndex == 0
                        ? Colors.white
                        : Colors.white.withOpacity(0.8),
                    iconSize: 30,
                    onPressed: () {
                      _onItemTapped(2);
                    },
                  ),
                ],
              ),
            ) : SizedBox(),
          )
        ],
      ),
    );
  }
}
