final String table = "match";
final String idColumn = "id";
final String userIdColumn = "userId";
final String foodIdColumn = "foodId";

class UserMatch {
  int id;
  int userId;
  int foodId;

  UserMatch();

  UserMatch.fromMap(Map map) {
    id = map[idColumn];
    userId = map[userIdColumn];
    foodId = map[foodIdColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {userIdColumn: userId, foodIdColumn: foodId};

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
