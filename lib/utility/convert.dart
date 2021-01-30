import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Convert {
  String getJapaneseDateFormat(DateTime dateTime) {
    initializeDateFormatting('ja');
    final yearMonthDayWeekDay = DateFormat.yMMMEd('ja').format(dateTime);
    final hourMinute = DateFormat.Hm('ja').format(dateTime);
    return yearMonthDayWeekDay + ' ' + hourMinute;
  }
}
