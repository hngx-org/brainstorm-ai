import 'package:intl/intl.dart';

class Utils {

  static String toFlatTimestamp(DateTime datetime){
    return datetime.toString().replaceAll(' ', '').replaceAll('-', '').replaceAll(':', '').replaceAll('.', '');
  }

  static DateTime toDateTIme(String flatTimestamp){
    String year = flatTimestamp.substring(0, 4);
    String month = flatTimestamp.substring(4, 6);
    String day = flatTimestamp.substring(6, 8);
    String hour = flatTimestamp.substring(8, 10);
    String minute = flatTimestamp.substring(10, 12);
    String second = flatTimestamp.substring(12, 14);
    String milliSecond = flatTimestamp.substring(14);
    return DateTime.parse('$year-$month-$day $hour:$minute:$second.$milliSecond');
  }

  static String formatChatName(String text){
    int maxChatNameLength = 20;

    List<String> words = text.split(' ');

    String joinedWords = words
        .take(maxChatNameLength)
        .map((word) => word.replaceAll('?', ''))
        .join('0');

    String shortenedChatName = joinedWords.length <= maxChatNameLength
        ? joinedWords
        : joinedWords.substring(0, maxChatNameLength);

    String timeStamp = Utils.toFlatTimestamp(DateTime.now());

    final chatName = '${shortenedChatName}_$timeStamp';

    return chatName;
  }

  static String formatDisplayChatName(String text){
    List<String> parts = text.split('_');

    String chatNameWithoutTimestamp = parts[0];

    String cleanedChatName = chatNameWithoutTimestamp.replaceAll('0', ' ');

    String timeStampPart = parts.length > 1 ? parts[1] : '';

    DateTime timeStampDateTime = Utils.toDateTIme(timeStampPart);

    String formattedTimeStamp = DateFormat('dd/MM').format(timeStampDateTime);

    // Combine the formatted timestamp and the cleaned chat name
    String displayChatName = '($formattedTimeStamp) ${cleanedChatName}... ';
    return displayChatName;
  }
}