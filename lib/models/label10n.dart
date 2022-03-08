// * https://app.quicktype.io/

// 🎯 Dart imports:
import "dart:convert";

// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 🌎 Project imports:
import "package:food_busters/main.dart";

class Label10n {
  Label10n({
    required this.en,
    this.th,
  });

  final String en;
  final String? th;

  String get(BuildContext context) {
    if (th == null) return en;

    final lang = MyApp.of(context).localeStrSimp;

    if (lang == "th") {
      return th!;
    } else {
      return en;
    }
  }

  factory Label10n.fromRawJson(String str) =>
      Label10n.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Label10n.fromJson(Map<String, dynamic> json) => Label10n(
        en: json["en"],
        th: json["th"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "th": th,
      };
}
