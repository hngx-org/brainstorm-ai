import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponseContainer extends StatelessWidget {
  final String content;
  const ResponseContainer({
    required this.content,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15
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
                      backgroundImage: AssetImage('assets/png/logo try.png')
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        content,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14
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
                        ClipboardData(text: content)
                      ).then((_){
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('copied to clipboard'))
                        );
                      });
                    },
                    child: const Icon(Icons.copy)
                  )
                ],
              )
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