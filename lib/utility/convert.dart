import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Convert {
  String getYearMonthDayWeekDayHourMinute(DateTime dateTime) {
    initializeDateFormatting('ja');
    final yearMonthDayWeekDay = DateFormat.yMMMEd('ja').format(dateTime);
    final hourMinute = DateFormat.Hm('ja').format(dateTime);
    return yearMonthDayWeekDay + ' ' + hourMinute;
  }

  String getMonthDayWeekDay(DateTime dateTime) {
    initializeDateFormatting('ja');
    final monthDayWeekDay = DateFormat.MEd('ja').format(dateTime);
    return monthDayWeekDay;
  }

  double getHourMinute(DateTime dateTime) {
    final hour = DateFormat.H().format(dateTime);
    final minute = DateFormat.m().format(dateTime);
    final hourMinute =
        double.parse(hour) + (double.parse(minute) / 60); //時間と分を小数に変換
    return (hourMinute * 10).roundToDouble() / 10; //小数点第二位以下を四捨五入で切り上げ
  }
}
