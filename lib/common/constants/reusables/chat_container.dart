import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponseContainer extends StatefulWidget {
  final String content;
  final bool isNewQueryResponse;
  const ResponseContainer({
    required this.content,
    super.key, required this.isNewQueryResponse,
  });

  @override
  _ResponseContainerState createState() => _ResponseContainerState();
}

class _ResponseContainerState extends State<ResponseContainer> {
  String displayedText = '';
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    // Start displaying text letter by letter when the widget is created
    if (widget.isNewQueryResponse) {
      // Start displaying text letter by letter for new query responses
      displayTextLetterByLetter();
    } else {
      // Display the response immediately for old queries
      displayedText = widget.content;
    }
  }

  void displayTextLetterByLetter() async {
    for (int i = 0; i < widget.content.length; i++) {
      setState(() {
        if (isMounted) {
          setState(() {
            displayedText = widget.content.substring(0, i + 1);
          });
        }
      });
      await Future.delayed(const Duration(milliseconds: 50)); // Adjust delay as needed
    }
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox.square(
                    dimension: 40,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/png/logo try.png'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        displayedText, // Displayed text updates as letters are added
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(
                        ClipboardData(text: widget.content),
                      ).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('copied to clipboard')),
                        );
                      });
                    },
                    child: const Icon(Icons.copy),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class QueryContainer extends StatelessWidget {
  final String content;
  const QueryContainer({
    required this.content,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox.square(
            dimension: 40,
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          const SizedBox(width: 15,),
          Expanded(
            child: SizedBox(
              child: Text(
                content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}