import 'dart:async';

final String table = "food";
final String idColumn = "id";
final String restaurantIdColumn = "restaurantId";
final String imageColumn = "image";
final String priceColumn = "price";
final String descriptionColumn = "description";
final String activeColumn = "active";

class Food {
  int id;
  int restaurantId;
  String image;
  double price;
  String description;
  int active;

  Food();

  Food.fromMap(Map map) {
    id = map[idColumn];
    restaurantId = map[restaurantIdColumn];
    image = map[imageColumn];
    price = map[priceColumn];
    description = map[descriptionColumn];
    active = map[activeColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      restaurantIdColumn: restaurantId,
      imageColumn: image,
      priceColumn: price,
      descriptionColumn: description,
      activeColumn: active
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
