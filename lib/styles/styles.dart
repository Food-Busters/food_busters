// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/niku.dart";

final loginRegisterBtn = ElevatedButton.styleFrom(
  padding: const EdgeInsets.all(12.0),
  primary: tan,
);

final lightOrangeBtn = ElevatedButton.styleFrom(
  padding: const EdgeInsets.all(12.0),
  primary: lightOrange,
);

final lightGreenBtn = ElevatedButton.styleFrom(
  padding: const EdgeInsets.all(12.0),
  primary: lightGreen,
);

final greenBtn = ElevatedButton.styleFrom(
  padding: const EdgeInsets.all(12.0),
  primary: green,
);

final tanBtn = ElevatedButton.styleFrom(
  padding: const EdgeInsets.all(12.0),
  primary: tan,
);

const smallStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
const bigStyle = TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

const lightOrange = Color(0xFFFFC068);
const lightGreen = Color(0xFFBBDFC8);
const green = Color(0xFF5DC7AB);
const tan = Color(0xFFF4E4D8);
const brown = Color(0xFF533F2C);
const rose = Color(0xFFF1D0C5);

const discordPfp =
    "https://external-preview.redd.it/4PE-nlL_PdMD5PrFNLnjurHQ1QKPnCvg368LTDnfM-M.png?auto=webp&s=ff4c3fbc1cce1a1856cff36b5d2a40a6d02cc1c3";

const bold = TextStyle(fontWeight: FontWeight.w500);

// * 肉 Hooks

Center vCenter(Niku v) {
  return Center(child: v);
}
