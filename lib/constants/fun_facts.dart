// 🎯 Dart imports:
import "dart:math";

// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 🌎 Project imports:
import "package:food_busters/main.dart";

const facts = {
  "en": [
    "Do you know that 3.3 billion tons of "
        "carbon footprint are from food waste?",
    "Cheese makes you fart and also cause a lot of pollution when made!",
    "Mushroom tastes kinda like meat. Care to try?",
    "Grains are 'in' right now. Try one to be super healthy.",
    "Somwua is a cow! Not a buffalo!",
    "Eat everything on your plate. It helps make cleaning up easier as well.",
    "Food Busters will never give environment up, never gonna let ocean down. "
        "Never gonna run around and desert the world."
  ],
  "th": [
    "สมวัว คือ 'วัว'นะ ไม่ใช่ควาย 🐮😭 อย่าบูลลี่น้อนนน",
    "คุณรู้หรือไม่? ว่าคาร์บอนฟุตปริ้นท์กว่า 3.3 พันล้านตันมาจากเศษอาหาร"
  ]
};

String getRandomFact(BuildContext context) {
  final facts = getFacts(context);

  return facts[Random().nextInt(facts.length)];
}

List<String> getFacts(BuildContext context) {
  final locale = MyApp.of(context).localeStrSimp;

  if (locale == "th") return facts["th"]!;
  return facts["en"]!;
}
