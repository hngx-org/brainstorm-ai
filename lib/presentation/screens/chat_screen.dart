import 'package:ai_brainstorm/common/constants/reusables/chat_container.dart';
import 'package:ai_brainstorm/common/constants/reusables/transparent_film.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final String content = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ac justo eget nisi dignissim euismod in quis tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut odio diam, tempus sit amet consequat vitae, pretium vel est. Proin id pulvinar nunc. Cras porttitor maximus sem, quis accumsan enim consequat at. Duis ut vehicula felis. Morbi pulvinar enim et lacinia viverra. Nullam augue nunc, interdum fermentum nulla quis, efficitur maximus purus. Aenean porta ex enim, quis vehicula massa tincidunt eget. Integer sit amet facilisis nibh. Aenean eros diam, cursus ac facilisis vitae, vestibulum dapibus lorem. Sed nisi massa, mattis id luctus ac, imperdiet nec lectus.';
  late TextEditingController inputController; 
  late List<String> queries;
  late List<String> responses;
  @override
  void initState(){
    super.initState();
    inputController = TextEditingController();
    queries = [
      content
    ];
    responses = [
      content
    ];
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset('assets/png/bg.png')
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  DisplayContent(queries: queries, responses: responses),
                  const SizedBox(height: 20,),
                  const RegenerateButton(),
                  const SizedBox(height: 80,),
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
            const Align(
              alignment: Alignment.bottomCenter,
              child: BottomGradient(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InputArea(
                controller: inputController,
                extraOnTap: (){
                  setState(() {
                    inputController.text.isNotEmpty ? queries.add(inputController.text) : null;
                    inputController.text.isNotEmpty? responses.add(inputController.text) : null; //TODO: get from api first
                  });
                },
              )
            )
          ],
        ),
      ),
    );
  }
}

class InputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? extraOnTap;
  const InputArea ({
    required this.controller,
    this.extraOnTap,
    super.key});

  void submit(context){
    //TODO: send text from controller to openai api
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 35
                    ),
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write something ...',
                        hintStyle: TextStyle(
                          color: Colors.white30
                        )
                      ),
                      onSubmitted: (value) => submit(context),
                      onTapOutside: (_){
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  )
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox.square(
            dimension: 50,
            child: GestureDetector(
              onTap: ()=> submit(context),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white
                ),
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
  const DisplayContent({
    required this.queries,
    required this.responses,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        queries.length, 
        (index){
          return Column(
            children: [
              const SizedBox(height: 40,),
              QueryContainer(content: queries[index]),
              const SizedBox(height: 40,),
              ResponseContainer(content: responses[index])
            ],
          );
        }
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24
      ),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            SizedBox.square(
              dimension: 40,
              child: GestureDetector(
                onTap: (){
                  //TODO: navigate back to home
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400
                  ),
                )
              ),
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
      onTap: (){
        // TODO: regenerate last response
      },
      child: SizedBox(
        height: 50,
        width: 150,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white
            )
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.stop_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 10,),
              Text(
                'Regenerate',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
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
            colors: [Color.fromRGBO(0, 0, 0, 0.75), Colors.transparent]
          )
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // stops: [0, 0.5],
            colors: [Colors.transparent, Color.fromRGBO(0, 0, 0, 0.75)]
          )
        ),
      ),
    );
  }
}