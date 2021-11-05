import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/styles/styles.dart";

AlertDialog exchangeSuccess(
  AppLocalizations text,
  BuildContext context, {
  bool showQR = false,
}) =>
    AlertDialog(
      title: Text(text.exchange.toUpperCase(), textAlign: TextAlign.center),
      backgroundColor: lightGreen,
      content: showQR
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text.exchange_complete),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset("assets/images/dummy_QR.png"),
                ),
                Text(text.use_this_qr, style: const TextStyle(fontSize: 12)),
              ],
            )
          : Text(text.exchange_complete),
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
