import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/reusables/automated_qyns.dart';
import 'package:ai_brainstorm/common/constants/reusables/chat_container.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/transparent_film.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:ai_brainstorm/data/openai_test.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController inputController;
  late List<String> queries;
  late List<String> responses;
  String generatedText = '';

  bool isNewQuery = true;
  List<bool> isNewQueryResponseList = [false];

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
    queries = [''];
    responses = [''];
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Stack(
      children: [
        CustomBackground(),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      DisplayContent(queries: queries, responses: responses, isNewQueryResponseList: isNewQueryResponseList,),
                      const SizedBox(
                        height: 20,
                      ),
                      if (queries.length != 1 ) RegenerateButton(),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: TopGradient(),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: TopSection(),
                ),
                if (queries.length == 1 ) Positioned(bottom: 120, child: Container( height: 150, width: mediaQuery.width, child: AutomatedQuestions(mediaQuery: mediaQuery))),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomGradient(),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: InputArea(
                      controller: inputController,
                      extraOnTap: () {
                        setState(() {
                          if (inputController.text.isNotEmpty) {
                            queries.add(inputController.text);
                          }
                        });
                      },
                      updateGeneratedText: (text) {
                        setState(() {
                          // Always set generatedText to the provided text
                          generatedText = text;
                          isNewQuery = true;
                          print(' new text: $generatedText');

                          // Reset all values to false
                          for (int i = 0; i < isNewQueryResponseList.length; i++) {
                            isNewQueryResponseList[i] = false;
                          }

                          responses.add(generatedText);
                          print(responses.length);
                          isNewQueryResponseList.add(true);
                        });
                      },
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? extraOnTap;
  final Function(String) updateGeneratedText;
  const InputArea(
      {required this.controller,
      this.extraOnTap,
      super.key,
      required this.updateGeneratedText});

  Future<void> submit(context) async {
    //TODO: send text from controller to openai api
    // final generatedText = await OpenAiTest().generateText('Translate the following English text to French: "Hello, how are you?"');
    //
    final generatedText = 'hey how are you today, welcome to brainstorm-ai how may i be of assistance';
    updateGeneratedText(generatedText);

    FocusScope.of(context).requestFocus(FocusNode());
    extraOnTap!();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TransparentFilm.light(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 35),
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: AppColor.whiteOpacity8),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write something ...',
                        hintStyle: TextStyle(color: Colors.white30)),
                    onSubmitted: (value) => submit(context),
                    onTapOutside: (_) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                )),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox.square(
            dimension: 50,
            child: GestureDetector(
              onTap: () => submit(context),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColor.whiteOpacity8),
                child: const Center(
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DisplayContent extends StatelessWidget {
  final List<String> queries;
  final List<String> responses;
  final List<bool> isNewQueryResponseList;
  const DisplayContent(
      {required this.queries, required this.responses, super.key, required this.isNewQueryResponseList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(queries.length, (index) {
        final bool isNewQueryResponse = isNewQueryResponseList[index];
        final String response = responses[index];
        print(isNewQueryResponse);

        if (isNewQueryResponse || response.isNotEmpty) {
          return Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              QueryContainer(content: queries[index]),
              const SizedBox(
                height: 40,
              ),
              ResponseContainer(content: response, isNewQueryResponse: isNewQueryResponse)
            ],
          );
        }else {
          // Don't display if it's not a new query response and the response is empty
          return Container(); // Empty container
        }
      }),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            SizedBox.square(
              dimension: 40,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColor.whiteOpacity8),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black,
                    iconSize: 24,
                    onPressed: () {
                      final fN = SharedPreferencesManager.prefs
                              .getString('first_name') ??
                          '';
                      final lN = SharedPreferencesManager.prefs
                              .getString('last_name') ??
                          '';

                      routerConfig.pushReplacement(RoutesPath.nav, extra: {
                        'first_name': fN,
                        'last_name': lN,
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                  child: Text(
                'Chat',
                style: TextStyle(
                    color: AppColor.whiteOpacity8,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              )),
            )
          ],
        ),
      ),
    );
  }
}

class RegenerateButton extends StatelessWidget {
  const RegenerateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: regenerate last response
      },
      child: SizedBox(
        height: 50,
        width: 150,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColor.whiteOpacity8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.stop_outlined,
                color: AppColor.whiteOpacity8,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Regenerate',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color:AppColor.whiteOpacity8),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopGradient extends StatelessWidget {
  const TopGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(0, 0, 0, 0.75), Colors.transparent])),
      ),
    );
  }
}

class BottomGradient extends StatelessWidget {
  const BottomGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // stops: [0, 0.5],
            colors: [Colors.transparent, Color.fromRGBO(0, 0, 0, 0.75)])),
      ),
    );
  }
}
