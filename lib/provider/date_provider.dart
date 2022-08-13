import 'package:flutter/foundation.dart';

class DateProvider with ChangeNotifier {

  String todayDateIs = DateTime.now().day.toString();

  changeSelectedDate(String date) {
    todayDateIs = date;
    notifyListeners();
  }

}