import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/reusables/automated_qyns.dart';
import 'package:ai_brainstorm/common/constants/reusables/back_button.dart';
import 'package:ai_brainstorm/common/constants/reusables/chat_container.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/transparent_film.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final int automated;
  const ChatScreen({super.key, required this.automated});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController inputController;
  late List<String> queries;
  late List<String> responses;
  late ScrollController scrollController;
  bool isAnimationInProgress = false;

  bool isAutomated = false;
  String generatedText = '';
  int automated  = 0;

  bool isNewQuery = true;
  List<bool> isNewQueryResponseList = [false];

  @override
  void initState() {
    super.initState();
    automated = widget.automated;
    inputController = TextEditingController();
    scrollController = ScrollController();
    SendAutomatedChat(context);
  }

  Future<void> SendAutomatedChat(context) async {

    setState(() {
      isAutomated = true;
    });
    queries = [''];
    responses = [''];
    if (automated == 1) {
      setState(() {
        queries.add('Kindly write an article on the Impact of Artificial'
            ' Intelligence in Healthcare');
        isNewQuery = true;

        generatedText = 'The Impact of Artificial Intelligence in Healthcare '
            'In recent years, the healthcare industry has witnessed a revolutionary transformation driven by the integration of Artificial Intelligence (AI) technologies. From early disease detection to personalized treatment plans, AI has begun to play a pivotal role in reshaping healthcare as we know it. The impact of AI in healthcare is profound and holds immense potential to improve patient outcomes, reduce costs, and enhance overall healthcare quality.';
        // Reset all values to false
        for (int i = 0; i < isNewQueryResponseList.length; i++) {
          isNewQueryResponseList[i] = false;
        }

        responses.add(generatedText);
        print(' le response: ${responses.length}');
        isNewQueryResponseList.add(true);
      });
    }
    else if(automated == 2){
      setState(() {
        queries.add('Kindly write a short paragraph Investigating Quantum Computing Applications for Optimization Problems');
        isNewQuery = true;

        generatedText = 'Investigating Quantum Computing Applications for Optimization Problems holds the promise of unlocking unprecedented computational power to tackle some of the most complex and resource-intensive challenges in various fields, from logistics and finance to drug discovery and cryptography. Quantum computing\'s ability to explore multiple solutions simultaneously using quantum bits (qubits) offers the potential to revolutionize optimization processes, leading to faster, more efficient solutions that were previously beyond the capabilities of classical computers. As researchers delve deeper into harnessing the power of quantum computing, we stand on the brink of transformative breakthroughs that could reshape industries and our understanding of computational limits.';
        // Reset all values to false
        for (int i = 0; i < isNewQueryResponseList.length; i++) {
          isNewQueryResponseList[i] = false;
        }

        responses.add(generatedText);
        print(responses.length);
        isNewQueryResponseList.add(true);
      });
    } else if (automated == 3){
      setState(() {
        queries.add('Analyze one Role of Environmental Factors in Climate Change');
        isNewQuery = true;

        generatedText = 'Greenhouse Gas Emissions: Human activities, such as the burning of fossil fuels, deforestation, and industrial processes, release greenhouse gases (GHGs), including carbon dioxide (CO2), methane (CH4), and nitrous oxide (N2O), into the atmosphere. These gases trap heat, leading to an enhanced greenhouse effect and global warming.';
        // Reset all values to false
        for (int i = 0; i < isNewQueryResponseList.length; i++) {
          isNewQueryResponseList[i] = false;
        }

        responses.add(generatedText);
        print(responses.length);
        isNewQueryResponseList.add(true);
      });
    }
    else if(automated == 4){
      setState(() {
        queries.add('Give me one Machine Learning Algorithms for Financial Forecasting');
        isNewQuery = true;

        generatedText = 'Memory Cells: LSTM networks contain memory cells that can store and retrieve information over long sequences of data. This capability allows LSTMs to capture complex patterns and relationships in financial data that traditional models may struggle to grasp.';
        // Reset all values to false
        for (int i = 0; i < isNewQueryResponseList.length; i++) {
          isNewQueryResponseList[i] = false;
        }

        responses.add(generatedText);
        print(responses.length);
        isNewQueryResponseList.add(true);
      });
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    scrollController.dispose();
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
                      DisplayContent(
                        queries: queries,
                        responses: responses,
                        isNewQueryResponseList: isNewQueryResponseList,
                        scrollController: scrollController,
                        onAnimationComplete: (bool animationFinished) {
                        setState(() {
                          isAnimationInProgress = animationFinished;
                        });
                      },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (queries.length != 1) RegenerateButton(),
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
                  child: TopSection(
                    middleText: 'Chat',
                  ),
                ),
                if (queries.length == 1 || !isAutomated)
                  Positioned(
                      bottom: 120,
                      child: Container(
                          height: 150,
                          width: mediaQuery.width,
                          child: AutomatedQuestions(mediaQuery: mediaQuery))),
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

                          // Reset all values to false
                          for (int i = 0;
                              i < isNewQueryResponseList.length;
                              i++) {
                            isNewQueryResponseList[i] = false;
                          }

                          responses.add(generatedText);
                          print(responses.length);
                          isNewQueryResponseList.add(true);
                        });
                      }, scrollController: scrollController,
                      isAnimationInProgress: isAnimationInProgress,
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
  final ScrollController scrollController;
  final bool isAnimationInProgress;

  const InputArea(
      {required this.controller,
      this.extraOnTap,
      super.key,
      required this.updateGeneratedText, required this.scrollController,
        required this.isAnimationInProgress, });

  Future<void> submit(context) async {
    //TODO: send text from controller to openai api
    // final generatedText = await OpenAiTest().generateText('Translate the following English text to French: "Hello, how are you?"');
    //
    final generatedText =
        'hey how are you today, welcome to brainstorm-ai how may i be of assistance';
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
                    enabled: isAnimationInProgress,
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
              onTap: () {
                if (!isAnimationInProgress) {
                  submit(context);
                }
              },
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
  final ScrollController scrollController;
  final Function(bool) onAnimationComplete;

  const DisplayContent(
      {required this.queries,
      required this.responses,
      super.key,
      required this.isNewQueryResponseList, required this.scrollController, required this.onAnimationComplete});


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to the bottom of the chat after the frame is built
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    return Column(
      children: List.generate(queries.length, (index) {
        final bool isNewQueryResponse = isNewQueryResponseList[index];
        final String response = responses[index];

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
              ResponseContainer(
                content: response, isNewQueryResponse: isNewQueryResponse,
                onAnimationComplete: (bool animationFinished) {
                Future.delayed(Duration.zero, () {
                  onAnimationComplete(animationFinished);
                  print('display $animationFinished');
                });
              },)
            ],
          );
        } else {
          // Don't display if it's not a new query response and the response is empty
          return Container(); // Empty container
        }

      }),
    );
  }
}

class TopSection extends StatelessWidget {
  final String middleText;
  const TopSection({super.key, required this.middleText});

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
              left: 10,
              child: SizedBox.square(
                dimension: 40,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColor.whiteOpacity8),
                  child: Center(
                    child: BackButtonWidget()
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                  child: Text(
                middleText,
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
                    color: AppColor.whiteOpacity8),
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
