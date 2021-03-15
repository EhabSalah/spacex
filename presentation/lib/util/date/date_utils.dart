import 'package:intl/intl.dart';

final appDatePattern = 'd MMM yyyy';

DateTime stringDateToDateTime(String date) {
  return DateTime.parse(date);
}

DateTime stringServerPublicToDateTime(String stringDate) {
  /// ex: "2021-02-04 01:29 PM" -> DateTime().toString()
  /// -> 2021-02-04 13:29:00.000

  return Intl.withLocale(
      'en', () => DateFormat("yyyy-MM-dd hh:mm a").parse(stringDate));
}

String dateToAppDate(DateTime date) {
  return DateFormat(appDatePattern).format(date);
}
