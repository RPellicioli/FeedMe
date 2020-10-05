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

  Restaurant();

  Restaurant.fromMap(Map map) {
    id = map[idColumn];
    userId = map[userIdColumn];
    name = map[nameColumn];
    cnpj = map[cnpjColumn];
    cep = map[cepColumn];
    number = map[numberColumn];
    street = map[streetColumn];
    complement = map[complementColumn];
    neighborhood = map[neighborhoodColumn];
    city = map[cityColumn];
    state = map[stateColumn];
    longitude = map[longitudeColumn];
    latitude = map[latitudeColumn];
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
