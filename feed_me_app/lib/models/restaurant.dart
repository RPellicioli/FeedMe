final String table = "restaurant";
final String idColumn = "id";
final String userIdColumn = "userId";
final String nameColumn = "name";
final String cnpjColumn = "cnpj";
final String cepColumn = "cep";
final String numberColumn = "number";
final String streetColumn = "street";
final String complementColumn = "complement";
final String neighborhoodColumn = "neighborhood";
final String cityColumn = "city";
final String stateColumn = "state";
final String longitudeColumn = "longitude";
final String latitudeColumn = "latitude";

class Restaurant {
  int id;
  int userId;
  String name;
  int cnpj;
  int cep;
  int number;
  String street;
  String complement;
  String neighborhood;
  String city;
  String state;
  double longitude;
  double latitude;

  Restaurant(
      this.id,
      this.userId,
      this.name,
      this.cnpj,
      this.cep,
      this.number,
      this.street,
      this.complement,
      this.neighborhood,
      this.city,
      this.state,
      this.longitude,
      this.latitude);

  factory Restaurant.fromJson(dynamic json) {
    return Restaurant(
        json[idColumn] as int,
        json[userIdColumn] as int,
        json[nameColumn] as String,
        json[cnpjColumn] as int,
        json[cepColumn] as int,
        json[numberColumn] as int,
        json[streetColumn] as String,
        json[streetColumn] as String,
        json[complementColumn] as String,
        json[cityColumn] as String,
        json[stateColumn] as String,
        json[longitudeColumn] as double,
        json[latitudeColumn] as double);
  }

  Map toMap() {
    Map<String, dynamic> map = {
      userIdColumn: userId,
      nameColumn: name,
      cnpjColumn: cnpj,
      cepColumn: cep,
      numberColumn: number,
      streetColumn: street,
      complementColumn: complement,
      neighborhoodColumn: neighborhood,
      cityColumn: city,
      stateColumn: state,
      longitudeColumn: longitude,
      latitudeColumn: latitude
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
