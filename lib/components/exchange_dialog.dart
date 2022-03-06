// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/hooks.dart";

// 🌎 Project imports:
import "package:food_busters/styles/styles.dart";

AlertDialog exchangeSuccess(
  BuildContext context, {
  bool showQR = false,
}) {
  final t = useTranslation(context);

  return AlertDialog(
    title: Text(t.exchange.toUpperCase(), textAlign: TextAlign.center),
    backgroundColor: lightGreen,
    content: showQR
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(t.exchange_complete),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.asset("assets/images/dummy_QR.png"),
              ),
              Text(t.use_this_qr, style: const TextStyle(fontSize: 12)),
            ],
          )
        : Text(t.exchange_complete),
    actions: [
      TextButton(
        child: Text(
          t.window_close,
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
}

AlertDialog exchangeFailed(BuildContext context) {
  final t = useTranslation(context);

  return AlertDialog(
    title: Text(t.exchange.toUpperCase(), textAlign: TextAlign.center),
    backgroundColor: rose,
    content: Text(t.exchange_failed),
    actions: [
      TextButton(
        child: Text(
          t.window_close,
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
}
