import "dart:convert";

RestaurantMenu restaurantMenuFromJson(String str) =>
    RestaurantMenu.fromJson(json.decode(str));

class RestaurantMenu {
  String menuName;
  String restaurantName;
  String menuPicture;
  int price;
  int points;
  int healthiness;

  RestaurantMenu({
    required this.menuName,
    required this.restaurantName,
    required this.menuPicture,
    required this.price,
    required this.points,
    required this.healthiness,
  });

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) => RestaurantMenu(
        menuName: json["menuName"],
        restaurantName: json["restaurantName"],
        menuPicture: json["menuPicture"],
        price: json["price"],
        points: json["points"],
        healthiness: json["healthiness"],
      );
}
