import 'package:intl/intl.dart';

String todayDate() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MMMM dd, yyyy');
  String formatted = formatter.format(now);
  return formatted;
}