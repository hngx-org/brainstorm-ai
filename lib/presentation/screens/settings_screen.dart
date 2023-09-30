import 'package:ai_brainstorm/common/constants/reusables/transparent_film.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final String firstname;
  final String lastname;
  const SettingsScreen({super.key, required this.firstname, required this.lastname});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset('assets/png/bg.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40,),
                Text( // TODO: chang this to show the actual username
                  '${widget.firstname} ${widget.lastname}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
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
                            SizedBox(
                              width: 200,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Upgrade to premium',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
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
                            SizedBox.square(
                              dimension: 40,
                              child: GestureDetector(
                                onTap: (){
                                  //TODO: navigate to purchase premium screen
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white
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
                                //TODO: navigate to my accounts
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.person_outline, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text(
                                      'My Account',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                //TODO: go to chat history
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.history, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text(
                                      'Chat History',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                //TODO: go to preferences screen
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.settings_outlined, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text(
                                      'Preferences',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                //TODO: logout
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.logout, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                        color: Colors.white,
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
    );
  }
}