import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/custom_error_dialog.dart';
import 'package:ai_brainstorm/common/constants/reusables/back_button.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/transparent_film.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/data/models/chat_model.dart';
import 'package:ai_brainstorm/data/others/utils.dart';
import 'package:flutter/material.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  late ChatModel model;
  bool isChatEmpty = false;

  void checkChatEmpty() async {
    final isChatEmptyDB = await ChatModel().chatTitles.then((titles) => titles.isEmpty);
    setState(() {
      isChatEmpty = isChatEmptyDB;
    });
  }

  @override
  void initState(){
    super.initState();
    checkChatEmpty();
    model = ChatModel()
      ..addListener(() {
        setState(() { });
      }
    );
  }
  @override
  void dispose(){
    model.dispose();
    super.dispose();
  }
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {

    void showSnackBar(String message, Color color) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }

    Future<void> deleteAllChat () async {
      ChatModel().deleteAll();
      setState(() {
        isChatEmpty = true;
      });
      showSnackBar('Chats cleared', Colors.grey);
      await Future.delayed(const Duration(seconds: 2));
      while(routerConfig.canPop()){
        routerConfig.pop();
      }
    }

    Future<void> alertToDelete() async {
      CustomDialog().showAlertDialog(context, 'alert', 'Delete Chat?', 'Are you sure you want to do this? '
          'Please, are you?', 'yes', deleteAllChat);
    }

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: Stack(
          children: [
            const CustomBackground(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: model.chatTitles,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return ListView(
                      children: [
                        const SizedBox(height: 10,),
                        TopSection(deleteAllChat: alertToDelete, isChatEmpty: isChatEmpty, ),
                        const SizedBox(height: 20,),
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
                                  children: List.generate(snapshot.data!.length, (index){
                                    return Dismissible(
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
                                        model.deleteChat(snapshot.data![index]);
                                        setState(() { });
                                      },
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              routerConfig.push(
                                                RoutesPath.chatScreen,
                                                extra: {'chatName': snapshot.data![index]}
                                              );
                                            },
                                            child: ListTile(
                                              title: Text(
                                                Utils.formatDisplayChatName(snapshot.data![index]),
                                                style: TextStyle(
                                                  color: AppColor.whiteOpacity8,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            )
                                          ),
                                          Divider(color: AppColor.whiteOpacity8.withOpacity(0.3))
                                        ]
                                      ),
                                    );
                                  })
                                ),
                              )
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }
              ),
            ),
          ],
        )
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  final VoidCallback deleteAllChat;
  final bool isChatEmpty;
  const TopSection({
    super.key, required this.deleteAllChat, required this.isChatEmpty});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: SizedBox.square(
                dimension: 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColor.whiteOpacity8.withOpacity(0.8)
                  ),
                  child: const Center(
                    child: BackButtonWidget()
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Chat History',
                style: TextStyle(
                  color: AppColor.whiteOpacity8.withOpacity(0.8),
                  fontSize: 22,
                  fontWeight: FontWeight.w400
                ),
              )
            ),
            if(!isChatEmpty) Positioned(
              right: 0,
              child: GestureDetector(
                onTap: deleteAllChat,
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: AppColor.whiteOpacity8,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
