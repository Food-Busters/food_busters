// * https://app.quicktype.io/

// To parse this JSON data, do
//
//     final quote = quoteFromJson(jsonString);

import "dart:convert";

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));

String quoteToJson(Quote data) => json.encode(data.toJson());

class Quote {
  Quote({
    this.error,
    this.quote,
  });

  final String? error;
  final String? quote;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        error: json["error"],
        quote: json["quote"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "quote": quote,
      };
}
