import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/reusables/back_button.dart';
import 'package:ai_brainstorm/common/constants/reusables/chat_container.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/glow_logo.dart';
import 'package:ai_brainstorm/common/constants/reusables/text.dart';
import 'package:ai_brainstorm/common/constants/reusables/transparent_film.dart';
import 'package:ai_brainstorm/data/models/chat_model.dart';
import 'package:ai_brainstorm/data/models/message_model.dart';
import 'package:ai_brainstorm/data/others/utils.dart';
import 'package:flutter/material.dart';
import 'package:ai_brainstorm/data/others/fake_generated_text.dart';

class ChatScreen extends StatefulWidget {
  final Message? initialQuery;
  final String? chatName;

  const ChatScreen({
    super.key,
    this.initialQuery,
  }): chatName = null;

  const ChatScreen.fromOldChat({
    super.key,
    required this.chatName,
  }): initialQuery = null;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController inputController;
  late ScrollController scrollController;
  late List<Message> messages;
  late ChatModel model;
  String? chatName;
  late FakeGenerator fakegen;
  late bool isGenerating;

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
    scrollController = ScrollController();
    model = ChatModel()
    ..addListener(() {
      setState(() { });
    });
    isGenerating = false;
    messages = [];
    fakegen = FakeGenerator();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.initialQuery != null){

        final shortQuery = widget.initialQuery!.message.trim();
        chatName = Utils.formatChatName(shortQuery);

        model.createChat(chatName!);
        isGenerating = true;
        generate(widget.initialQuery!.message);
        isGenerating = false;
      }
      else if (widget.chatName != null){
        model.readChat(widget.chatName).then((value){
          setState(() {
            chatName = widget.chatName!;
            messages = value;
          });
        });
      }
    });
  }
  @override
  void setState(fn){ 
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    scrollController.dispose();
    model.dispose();
    fakegen.dispose();
    super.dispose();
  }
  void generate(String query) async {
    if (chatName == null){
      chatName = Utils.formatChatName(query);
      model.createChat(chatName!);
    }
    setState(() {
      messages.add(
        Message(
          sender: Sender.user,
          message: query,
          timestamp: DateTime.now()
        )
      );
      isGenerating = true;
    });
    String generated = await fakegen.generate(query);
    setState(() {
      messages.add(
        Message(
          sender: Sender.gpt,
          message: generated,
          timestamp: DateTime.now()
        )
      );
      isGenerating = false;
    });
    model.addMessagePair(
      chatName!,
      Message(sender: Sender.user, message: query, timestamp: DateTime.now()),
      Message(sender: Sender.gpt, message: generated, timestamp: DateTime.now())
    );
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Stack(
      children: [
        const CustomBackground(),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      const SizedBox(height: 20),
                      DisplayContent(
                        messages: messages,
                        scrollController: scrollController,
                      ),
                      const SizedBox(height: 20),
                      messages.length > 1 && !isGenerating
                        ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RegenerateButton(),
                          ],
                        )
                        : const SizedBox.shrink(),
                      isGenerating ? const LoadingWidget() : const SizedBox.shrink(),
                      const SizedBox(height: 80),
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
                messages.isEmpty
                  ? Center(
                    child: SizedBox(
                        height: 150,
                        width: mediaQuery.width,
                        child: const Column(
                          children: [
                            GlowingLogo(size: 80),
                            CustomText(text: 'What would you like \nto talk about?',
                              fontSize: 22, maxLines: 2, textAlign: TextAlign.center
                            )
                          ],
                        )
                      ),
                    )
                  : const SizedBox.shrink(),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomGradient(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InputArea(
                    controller: inputController,
                    enabled: !isGenerating,
                    scrollController: scrollController,
                    extraOnTap: () async{
                      if (inputController.text.isNotEmpty) {
                        String query = inputController.text;
                        generate(query);
                      }
                    },
                  )
                )
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
  final VoidCallback extraOnTap;
  final ScrollController scrollController;
  final bool enabled;

  const InputArea({
    required this.controller,
    required this.extraOnTap,
    required this.scrollController,
    required this.enabled,
    super.key,
  });

  Future<void> submit(context) async {
    //TODO: send text from controller to openai api
    FocusScope.of(context).requestFocus(FocusNode());
    if(scrollController.hasClients){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn
        );
    }

    extraOnTap();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(26)
              ),
              child: Padding(
                padding: const EdgeInsets.all(1),
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
                        enabled: enabled,
                        onSubmitted: (value) => submit(context),
                        onTapOutside: (_) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox.square(
            dimension: 50,
            child: GestureDetector(
              onTap: () {
                submit(context); //TODO: dont submit when text is being generated
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
  final List<Message> messages;
  final ScrollController scrollController;

  const DisplayContent({
    required this.messages,
    required this.scrollController,
    super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    return Column(
      children: List.generate( messages.length,(index){
        Message message = messages[index];
        return Column(
          children: [
            const SizedBox(height: 40,),
            message.sender == Sender.gpt
            ? ResponseContainer(content: message.message)
            : QueryContainer(content: message.message),
          ]
        );
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
              left: 0,
              child: SizedBox.square(
                dimension: 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColor.whiteOpacity8
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
              middleText,
              style: TextStyle(
                  color: AppColor.whiteOpacity8,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ))
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColor.whiteOpacity8)),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  left: 16,
                  right: 20
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.stop_outlined,
                      color: AppColor.whiteOpacity8,
                    ),
                    const SizedBox(width: 8,),
                    Text(
                      'Regenerate',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteOpacity8
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
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
            colors: [Color.fromRGBO(0, 0, 0, 0.75), Colors.transparent])
        ),
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
          colors: [Colors.transparent, Color.fromRGBO(0, 0, 0, 0.75)])
        ),
      ),
    );
  }
}

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState(){
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() { });
      });
    controller.forward();
    controller.addListener(() {
      if(controller.isCompleted){
        controller.reverse();
      }
      if(controller.isDismissed) {
        controller.forward();
      }
    });
      
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
          width: 100,
          child: Stack(
            children: [
              Positioned(
                right: animation.value * 40,
                child: SizedBox.square(
                  dimension: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(animation.value)
                    ),
                  ),
                ),
              ),
              Positioned(
                left: animation.value * 40,
                child: SizedBox.square(
                  dimension: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(animation.value)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}