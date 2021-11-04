import "package:food_busters/data/delay.dart";

Future<Map<String, double>> getOmeletData() async {
  await serverRequest();

  return {
    "Carbohydrate": 65,
    "Fat": 15,
    "Protein": 20,
  };
}

Future<Map<String, double>> getChickenRiceData() async {
  await serverRequest();

  return {
    "Carbohydrate": 45,
    "Fat": 25,
    "Protein": 30,
  };
}
