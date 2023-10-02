import 'package:flutter/foundation.dart';
import 'package:ai_brainstorm/data/database/chat_database.dart';
import 'message_model.dart';

class ChatModel extends ChangeNotifier{

  ChatDatabase database = ChatDatabase();
  bool _disposed = false;

  bool get disposed => _disposed;

  Future<List<String>>  get chatTitles async {
    List<String> names = await database.allTableNames;
    names = names.toSet().toList();
    names.remove('android_metadata');
    return names;
  }

  void createChat(String title) async {
    database.create(title);
    if (!disposed){
      notifyListeners();
    }
  }

  Future<List<Message>> readChat(title) async {
    if (await chatTitles.then((t) => t.contains(title))){
      return database.read(title);
    }
    else{
      return [];
    }
  }

  void addMessagePair(String chatTitle, Message userQuery, Message gptResponse) async {
    database.update(chatTitle, userQuery);
    database.update(chatTitle, gptResponse);
    if (!disposed){
      notifyListeners();
    }
  }

  void deleteChat(String title) async {
    database.delete(title);
    if (!disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose(){
    _disposed = true;
    super.dispose();
  }
}