final String table = "match";
final String idColumn = "id";
final String foodIdColumn = "foodId";
final String nameColumn = "name";
final String imageColumn = "image";

class UserMatch {
  int id;
  int foodId;
  String name;
  String image;

  UserMatch(this.id, this.name, this.image);

  factory UserMatch.fromJson(dynamic json) {
    return UserMatch(json[idColumn] as int, json[nameColumn] as String,
        json[imageColumn] as String);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.image} }';
  }
}
