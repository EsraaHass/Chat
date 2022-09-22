import 'package:intl/intl.dart';

class FormateDate {
  static String formatMessageDate(int date) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(date);
    DateFormat dateFormat = DateFormat('hh:mm a');
    return dateFormat.format(dateTime);
  }
}
