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

  static String removeTimeStamp(String text){
      var t =  text.split('_');
      t.removeLast();
      return t.join('_');
  }
}