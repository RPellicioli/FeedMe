final String table = "user";
final String idColumn = "id";
final String nameColumn = "name";
final String emailColumn = "email";
final String passwordColumn = "password";
final String adminColumn = "admin";

class User {
  int id;
  String name;
  String email;
  String password;
  int admin;

  User();

  User.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    password = map[passwordColumn];
    admin = map[adminColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      passwordColumn: password,
      adminColumn: admin
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
