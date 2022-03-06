// 🌎 Project imports:
import "package:food_busters/models/state/account.dart";
import "package:food_busters/models/state/god.dart";
import "package:food_busters/models/state/image.dart";
import "package:food_busters/models/state/point.dart";

export "package:food_busters/models/state/god.dart" show Food;

class AppState with AccountState, GodModeState, ImageState, PointState {}
