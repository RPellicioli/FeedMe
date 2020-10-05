import 'dart:async';

final String table = "schedule";
final String idColumn = "id";
final String restaurantIdColumn = "restaurantId";
final String dayColumn = "day";
final String initialHourColumn = "initialHour";
final String finalHourColumn = "finalHour";

class Schedule {
  int id;
  int restaurantId;
  int day;
  int initialHour;
  int finalHour;

  Schedule();

  Schedule.fromMap(Map map) {
    id = map[idColumn];
    restaurantId = map[restaurantIdColumn];
    day = map[dayColumn];
    initialHour = map[initialHourColumn];
    finalHour = map[finalHourColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      restaurantIdColumn: restaurantId,
      dayColumn: day,
      initialHourColumn: initialHour,
      finalHourColumn: finalHour
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
