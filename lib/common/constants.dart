import 'package:intl/intl.dart';

String todayDate() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MMMM dd, yyyy');
  String formatted = formatter.format(now);
  return formatted;
}

bool isLate(String formattedDate){
  DateTime currentDate = DateTime.now();
  DateFormat formatter = DateFormat('MMMM dd, yyyy');
  String formatted = formatter.format(currentDate);
  // Parse the two dates
  DateTime date = DateFormat('MMMM dd, yyyy').parse(formattedDate);
  return date.isBefore(currentDate) && formattedDate!=formatted;

}