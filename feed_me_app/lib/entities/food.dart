import 'package:feed_me_app/entities/restaurant.dart';

final String table = "food";
final String idColumn = "id";
final String restaurantIdColumn = "restaurantId";
final String nameColumn = "name";
final String restaurantNameColumn = "restaurantName";
final String streetColumn = "street";
final String neighborhoodColumn = "neighborhood";
final String cityColumn = "city";
final String stateColumn = "state";
final String numberColumn = "number";
final String imageColumn = "image";
final String priceColumn = "price";
final String distanceColumn = "distance";
final String descriptionColumn = "description";
final String activeColumn = "active";

class Food {
  int id;
  int restaurantId;
  String name;
  String restaurantName;
  String street;
  String neighborhood;
  String city;
  String state;
  int number;
  String image;
  double price;
  double distance;
  String description;
  int active;

  Food(
      this.id,
      this.restaurantId,
      this.name,
      this.restaurantName,
      this.street,
      this.number,
      this.neighborhood,
      this.city,
      this.state,
      this.image,
      this.price,
      this.distance,
      this.description,
      this.active);

  factory Food.fromJson(dynamic json) {
    return Food(
        json[idColumn] as int,
        json[restaurantIdColumn] as int,
        json[nameColumn] as String,
        json[restaurantNameColumn] as String,
        json[streetColumn] as String,
        json[numberColumn] as int,
        json[neighborhoodColumn] as String,
        json[cityColumn] as String,
        json[stateColumn] as String,
        json[imageColumn] as String,
        json[priceColumn] + 0.0 as double,
        json[distanceColumn] + 0.0 as double,
        json[descriptionColumn] as String,
        json[activeColumn] as int);
  }

  Map toMap() {
    Map<String, dynamic> map = {
      restaurantIdColumn: restaurantId,
      nameColumn: name,
      restaurantNameColumn: restaurantName,
      streetColumn: street,
      numberColumn: number,
      neighborhoodColumn: neighborhood,
      cityColumn: city,
      stateColumn: state,
      imageColumn: image,
      priceColumn: price,
      distanceColumn: distance,
      descriptionColumn: description,
      activeColumn: active
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
