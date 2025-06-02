import 'package:pigeon/pigeon.dart';

class CalendarEvent {
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
}
