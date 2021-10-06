// * https://app.quicktype.io/

// To parse this JSON data, do
//
//     final quote = quoteFromJson(jsonString);

import "dart:convert";

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));

class Quote {
  Quote({
    required this.quote,
    required this.lang,
  });

  final String quote;
  final String lang;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        quote: json["quote"],
        lang: json["lang"],
      );
}
