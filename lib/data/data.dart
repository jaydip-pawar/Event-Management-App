import 'package:gdsc_assessment/models/date_model.dart';
import 'package:gdsc_assessment/models/events_model.dart';

class Data {

  int daysInMonth(DateTime date){
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

}

List<DateModel> getDates(){

  DateTime dateTime = DateTime.now();
  int month = dateTime.month;
  int year = dateTime.year;
  int daysInMonth = Data().daysInMonth(DateTime(year, month));
  List<DateModel> dates = <DateModel>[];
  DateModel dateModel = DateModel();

  var weekday = {
    1 : "Mon",
    2 : "Tue",
    3 : "Wed",
    4 : "Thu",
    5 : "Fri",
    6 : "Sat",
    7 : "Sun"
  };

  for (int i = dateTime.day - 2; i <= daysInMonth; i++) {

    dateModel.date = i.toString();
    dateModel.weekDay = weekday[DateTime(year, month, i).weekday];
    dates.add(dateModel);
    dateModel = DateModel();
  }

  return dates;

}

List<EventsModel> getEvents(){

  List<EventsModel> events = <EventsModel>[];
  EventsModel eventsModel = EventsModel();

  //1
  eventsModel.imgeAssetPath = "assets/tileimg.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.desc = "Sports Meet in Galaxy Field";
  eventsModel.address = "Greenfields, Sector 42, Faridabad";
  events.add(eventsModel);

  eventsModel = EventsModel();

  //2
  eventsModel.imgeAssetPath = "assets/second.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.desc = "Art & Meet in Street Plaza";
      eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
  events.add(eventsModel);

  eventsModel = EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/music_event.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = EventsModel();


  //3
  eventsModel.imgeAssetPath = "assets/music_event.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = EventsModel();


  //3
  eventsModel.imgeAssetPath = "assets/music_event.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = EventsModel();


  return events;


}