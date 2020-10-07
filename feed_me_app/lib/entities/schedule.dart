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

  Schedule(
      this.id, this.restaurantId, this.day, this.initialHour, this.finalHour);

  factory Schedule.fromJson(dynamic json) {
    return Schedule(
        json[idColumn] as int,
        json[restaurantIdColumn] as int,
        json[dayColumn] as int,
        json[initialHourColumn] as int,
        json[finalHourColumn] as int);
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
