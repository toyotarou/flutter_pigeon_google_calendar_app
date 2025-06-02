import 'package:pigeon/pigeon.dart';

class CalendarEvent {
  int? id;
  String? title;
  String? description;
  String? location;
  int? startTimeMillis;
  int? endTimeMillis;
}

@HostApi()
abstract class CalendarApi {
  String getPlatformVersion();

  List<CalendarEvent> getCalendarEvents();

  void addCalendarEvent(CalendarEvent event);

  void deleteCalendarEvent(int eventId);
}
