import 'package:intl/intl.dart';

final serverDatePattern = 'yyyy-MM-dd';

String dateToServerDate(DateTime date) {
  return DateFormat(serverDatePattern).format(date);
}
