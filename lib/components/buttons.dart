// Flutter imports:
import "package:flutter/material.dart";

// Package imports:
import "package:flutter_gen/gen_l10n/app_localizations.dart";

// Project imports:
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
