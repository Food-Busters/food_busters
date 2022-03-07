// * https://app.quicktype.io/

// 🎯 Dart imports:
import "dart:convert";

class MLAPIError {
  MLAPIError({
    required this.message,
    required this.error,
  });

  final String message;
  final int error;

  factory MLAPIError.fromRawJson(String str) =>
      MLAPIError.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MLAPIError.fromJson(Map<String, dynamic> json) => MLAPIError(
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
      };
}
