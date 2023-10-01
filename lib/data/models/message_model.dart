enum Sender {user, gpt}

class Message{

  final Sender sender;
  final String message;
  final DateTime timestamp;
  
  Message({
    required this.sender,
    required this.message,
    required this.timestamp
  });

  static Message fromMap(Map map){
    return Message(
      sender: (map['sender'] == 'user') ? Sender.user : Sender.gpt,
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']));
  }

  Map<String, dynamic> toMap(){
    return {
      'sender': (sender == Sender.user) ? 'user' : 'gpt',
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}