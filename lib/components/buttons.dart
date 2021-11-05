import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/styles/styles.dart";

Widget backHomeBtn(BuildContext context, AppLocalizations text) =>
    ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        text.back_to_home,
        style: const TextStyle(fontSize: 18),
      ),
      style: loginRegisterBtn,
    );
