// 🌎 Project imports:
import "package:food_busters/data/delay.dart";
import "package:food_busters/models/points_price.dart";

Future<List<PointsPrice>> getPointsPriceData() async {
  await serverRequest();

  return [
    PointsPrice(points: 50, price: 30),
    PointsPrice(points: 149, price: 75),
    PointsPrice(points: 280, price: 120),
    PointsPrice(points: 4999, price: 1499),
    PointsPrice(points: 9999, price: 2499)
  ];
}
