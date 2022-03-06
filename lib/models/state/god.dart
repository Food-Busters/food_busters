enum Food {
  chicken,
  omelet,
}

abstract class GodModeState {
  Food menu = Food.chicken;
  int get menuIndex => menu == Food.chicken ? 0 : 1;
  int percent = 50;
}
