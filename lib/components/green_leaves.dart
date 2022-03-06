// 🐦 Flutter imports:
import "package:flutter/material.dart";

List<Widget> greenLeaves(int count) {
  List<Widget> widgets = [];
  for (int i = 0; i < count; i++) {
    widgets.add(leaf);
  }
  return widgets;
}

List<Widget> bigGreenLeaves(int count) {
  List<Widget> widgets = [];
  for (int i = 0; i < count; i++) {
    widgets.add(bigLeaf);
  }
  return widgets;
}

List<Widget> bigNeonLeaves(int count) {
  List<Widget> widgets = [];
  for (int i = 0; i < count; i++) {
    widgets.add(bigNeonLeaf);
  }
  return widgets;
}

final leaf = Container(
  height: 30,
  width: 30,
  decoration: const BoxDecoration(
    shape: BoxShape.rectangle,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage("assets/images/leaf.png"),
    ),
  ),
);

final bigLeaf = Container(
  height: 60,
  width: 60,
  decoration: const BoxDecoration(
    shape: BoxShape.rectangle,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage("assets/images/leaf.png"),
    ),
  ),
);

final bigNeonLeaf = Container(
  height: 60,
  width: 60,
  decoration: const BoxDecoration(
    shape: BoxShape.rectangle,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage("assets/images/neon_leaf.png"),
    ),
  ),
);
