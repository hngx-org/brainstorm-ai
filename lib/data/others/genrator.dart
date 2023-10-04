import 'package:ai_brainstorm/data/others/utils.dart';
import 'package:hngx_openai/repository/openai_repository.dart';


class Generator{
  final openAI = OpenAIRepository();
  Future<String> generate(String query, String cookie) async{
    final response = openAI.getChat(query, cookie);
    return response.then((value){
      return Utils.formatResponse(value);
    });
  }
}