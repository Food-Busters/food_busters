import "dart:convert";

PointsPrice pointsPriceFromJson(String str) =>
    PointsPrice.fromJson(json.decode(str));

class PointsPrice {
  int points;
  int price;

  PointsPrice({
    required this.points,
    required this.price,
  });

  factory PointsPrice.fromJson(Map<String, dynamic> json) => PointsPrice(
        points: json["points"],
        price: json["price"],
      );
}
