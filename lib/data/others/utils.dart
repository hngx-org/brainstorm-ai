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
    text = text.replaceAll(RegExp('[^A-Za-z0-9]'), '_'); // only allows alphanumeric charcters
    text = text.length <= maxChatNameLength
        ? text
        : text.substring(0, maxChatNameLength);
    String timeStamp = Utils.toFlatTimestamp(DateTime.now());
    final chatName = '_${text}_$timeStamp';
    return chatName;
  }

  static String formatDisplayChatName(String text){

    List<String> parts = text.split('_');

    String flatTimeStamp = parts.removeLast();

    String cleanedChatName = parts.join(' ').trim();

    DateTime dateTime = Utils.toDateTIme(flatTimeStamp);

    String formattedTimeStamp = DateFormat('MMM / d -- HH : mm').format(dateTime);

    // Combine the formatted timestamp and the cleaned chat name
    String displayChatName = '$cleanedChatName ...\n$formattedTimeStamp';
    return displayChatName;
  }
}