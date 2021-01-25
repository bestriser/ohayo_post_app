import 'package:intl/intl.dart';

class Convert {
  String getJapaneseDateFormat(DateTime dateTime) {
    final yearMonthDayWeekDay = DateFormat.yMMMEd('ja').format(dateTime);
    final hourMinute = DateFormat('hh:mm').format(dateTime);
    return yearMonthDayWeekDay + hourMinute;
  }
}
