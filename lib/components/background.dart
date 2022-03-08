// 🐦 Flutter imports:
import "package:flutter/material.dart";

Image bgImage(String name) {
  return Image.asset(
    "assets/images/" + name,
    fit: BoxFit.cover,
    width: double.infinity,
    alignment: Alignment.center,
  );
}
