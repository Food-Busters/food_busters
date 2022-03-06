// 🌎 Project imports:
import "package:food_busters/data/delay.dart";
import "package:food_busters/models/food_record.dart";

Future<FoodRecord> getFoodRecord() async {
  await serverRequest();

  return FoodRecord(
    dessert: 10,
    fruit: 14,
    meat: 20,
    starch: 18,
    vegetable: 31,
  );
}
