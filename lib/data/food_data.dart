import "package:food_busters/data/delay.dart";
import "package:food_busters/models/health_record.dart";
import "dart:math";

final random = Random();

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

Map<String, double> getRandomNutrition() {
  final carbo = random.nextInt(15);
  final fat = random.nextInt(20 - carbo);
  final protein = 20 - fat - carbo;

  return {
    "Carbohydrate": carbo * 5,
    "Fat": fat * 5,
    "Protein": protein * 5,
  };
}

const restaurants = [
  "-",
  "Caesar Salad @ CP Best",
  "Stir fried Thai basil and fried egg @ Aroi Cusine",
  "Bread @ Rabbit House",
  "Coffee Anmitsu @ Rabbit House",
  "Donut @ Kakyoin Restaurant",
  "Donut @ Rengoku Restaurant",
];

String getRandomRestaurant() {
  return restaurants[random.nextInt(restaurants.length)];
}

HealthRecord getRandomHR() {
  return HealthRecord(
    nutrition: getRandomNutrition(),
    breakfast: getRandomRestaurant(),
    lunch: getRandomRestaurant(),
    dinner: getRandomRestaurant(),
  );
}

Map<String, HealthRecord> healthRecords = {};

DateTime getToday() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

const mockDays = 120;

Map<String, HealthRecord> getHealthRecord() {
  if (healthRecords.isEmpty) {
    final today = getToday();

    // * Fills last {mockDays} days with random data
    for (int i = 0; i <= mockDays; i++) {
      if (random.nextInt(100) >= 5) {
        healthRecords[today
            .subtract(Duration(days: i))
            .toString()
            .split(" ")[0]] = getRandomHR();
      }
    }
  }
  return healthRecords;
}

Future<HealthRecord?> getHealthStat(DateTime date) async {
  await serverRequest();

  return getHealthRecord()[date.toString().split(" ")[0]];
}
