import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

AppLocalizations useTranslation(BuildContext context) {
  return AppLocalizations.of(context)!;
}

typedef Translation = AppLocalizations;
