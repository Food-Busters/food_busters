// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:food_busters/hooks.dart";

// 🌎 Project imports:
import "package:food_busters/styles/styles.dart";

Widget backHomeBtn(BuildContext context) {
  final t = useTranslation(context);
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text(
      t.back_to_home,
      style: const TextStyle(fontSize: 18),
    ),
    style: loginRegisterBtn,
  );
}
