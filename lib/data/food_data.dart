import "package:food_busters/data/delay.dart";
import "package:food_busters/models/health_record.dart";

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

final Map<DateTime, HealthRecord> healthRecords = {
  DateTime.utc(2021, 11, 5): HealthRecord(
    nutrition: {
      "Carbohydrate": 45,
      "Fat": 25,
      "Protein": 30,
    },
    breakfast: "-",
    lunch: "Caesar Salad @ CP Best",
    dinner: "Stir fried Thai basil and fried egg @ Aroi Cusine",
  ),
  DateTime.utc(2021, 11, 6): HealthRecord(
    nutrition: {
      "Carbohydrate": 35,
      "Fat": 35,
      "Protein": 30,
    },
    breakfast: "Bread @ Rabbit House",
    lunch: "Donut @ Kakyoin's Restaurant",
    dinner: "-",
  ),
  DateTime.utc(2021, 11, 7): HealthRecord(
    nutrition: {
      "Carbohydrate": 45,
      "Fat": 15,
      "Protein": 40,
    },
    breakfast: "-",
    lunch: "Donut @ Rengoku's Restaurant",
    dinner: "Stir fried Thai basil and fried egg @ Aroi Cusine",
  ),
};

Future<HealthRecord?> getHealthStat(DateTime date) async {
  await serverRequest();

  return healthRecords[date];
}
