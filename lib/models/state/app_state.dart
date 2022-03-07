// 🌎 Project imports:
import "package:food_busters/models/state/account.dart";
import "package:food_busters/models/state/god.dart";
import "package:food_busters/models/state/image.dart";
import "package:food_busters/models/state/point.dart";

class AppState with AccountState, GodModeState, ImageState, PointState {
  void reset() {
    // todo implement database and this method
  }
}
