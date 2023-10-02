import 'package:ai_brainstorm/common/constants/reusables/back_button.dart';
import 'package:ai_brainstorm/common/constants/reusables/transparent_film.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/data/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  late ChatModel model;
  @override
  void initState(){
    super.initState();
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
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: model.chatTitles,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return ListView(
                    children: [
                      const SizedBox(height: 10,),
                      TopSection(model: model,),
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
                                              snapshot.data![index],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          )
                                        ),
                                        Divider(color: Colors.white.withOpacity(0.3))
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
                return const CircularProgressIndicator();
              }
            ),
          ),
        ],
      )
    );
  }
}

class TopSection extends StatelessWidget {
  final ChatModel model;
  const TopSection({
    required this.model,
    super.key});

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
                    color: Colors.white.withOpacity(0.8)
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
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 22,
                  fontWeight: FontWeight.w400
                ),
              )
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: (){
                  model.chatTitles.then((titles){
                    for (String title in titles){
                      model.deleteChat(title);
                    }
                  });
                },
                child: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white,
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
