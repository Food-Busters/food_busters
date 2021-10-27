import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/styles/styles.dart";

AlertDialog exchangeSuccess(AppLocalizations text, BuildContext context) =>
    AlertDialog(
      title: Text(text.exchange.toUpperCase(), textAlign: TextAlign.center),
      backgroundColor: lightGreen,
      content: Text(text.exchange_complete),
      actions: [
        TextButton(
          child: Text(
            text.window_close,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

AlertDialog exchangeFailed(AppLocalizations text, BuildContext context) =>
    AlertDialog(
      title: Text(text.exchange.toUpperCase(), textAlign: TextAlign.center),
      backgroundColor: rose,
      content: Text(text.exchange_failed),
      actions: [
        TextButton(
          child: Text(
            text.window_close,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
