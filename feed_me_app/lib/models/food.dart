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

  Food(this.id, this.restaurantId, this.image, this.price, this.description,
      this.active);

  factory Food.fromJson(dynamic json) {
    return Food(
        json[idColumn] as int,
        json[restaurantIdColumn] as int,
        json[imageColumn] as String,
        json[priceColumn] as double,
        json[descriptionColumn] as String,
        json[activeColumn] as int);
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
