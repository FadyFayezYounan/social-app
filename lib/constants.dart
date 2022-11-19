import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

const String KUserKey = 'currentUser';
const double KAppPadding = 16.0;

enum TimeFormat{
  monthDaysHoursMinutes,
  HoursMinutes,
}
String convertFromTimestampToTime({required Timestamp timestamp , required TimeFormat timeFormat}) {

  late String format;
  switch(timeFormat){
    case TimeFormat.monthDaysHoursMinutes:
      format = 'MM-dd, hh:mm a';
      break;
    case TimeFormat.HoursMinutes:
      format = 'hh:mm a';
      break;
  }
  return '${DateFormat(format).format(
    DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch),
  )}';
}
