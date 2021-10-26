import 'dart:html';

import "package:food_busters/models/points_price.dart";

Future<List<PointsPrice>> getPointsPriceData() async {
// * Simulate Server Request
  await Future.delayed(
    const Duration(milliseconds: 1000),
  );

  return [
    PointsPrice(points: 50, price: 30),
    PointsPrice(points: 149, price: 75),
    PointsPrice(points: 280, price: 120)
  ];
}
