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

  User(this.id, this.name, this.email, this.password, this.admin);

  factory User.fromJson(dynamic json) {
    return User(
        json[idColumn] as int,
        json[nameColumn] as String,
        json[emailColumn] as String,
        json[passwordColumn] as String,
        json[adminColumn] as int);
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
