import 'package:flutter/foundation.dart';
import 'package:ai_brainstorm/data/database/chat_database.dart';
import 'message_model.dart';

class ChatModel extends ChangeNotifier{

  ChatDatabase database = ChatDatabase();
  bool _disposed = false;

  bool get disposed => _disposed;

  Future<List<String>>  get chatTitles async {
    List<String> names = await database.allTableNames;
    names = names.toSet().toList().reversed.toList();
    names.remove('android_metadata');
    return names;
  }

  Stream<Future<List<String>>> streamChatTitles(){
    Stream<Future<List<String>>> chatStream = Stream.periodic(
      const Duration(seconds: 1),
      (_) => chatTitles
    );
    return chatStream;
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
    database.insert(chatTitle, userQuery);
    database.insert(chatTitle, gptResponse);
    if (!disposed){
      notifyListeners();
    }
  }

  Future<Message> removeLastMessagePair(String chatTitle) async {
    Future<List<Message>> chat = readChat(chatTitle);
    chat.then((c){
      if (c.length >= 2){
        database.remove(chatTitle, c.lastWhere((e) => e.sender == Sender.user));
        database.remove(chatTitle, c.lastWhere((e) => e.sender == Sender.gpt));
      }
    });
    if (!disposed){
      notifyListeners();
    }
    return chat.then((value){ // returns last query for regeneration
      return value.lastWhere((element) => element.sender == Sender.user);
    });
  }

  void deleteChat(String title) async {
    database.delete(title);
    if (!disposed) {
      notifyListeners();
    }
  }
  void deleteAll() async {
    for (String title in await chatTitles){
      deleteChat(title);
    }
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