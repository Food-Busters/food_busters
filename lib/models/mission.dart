import "package:food_busters/models/label10n.dart";

class Mission {
  Label10n obj;
  int award;

  Mission({
    required this.obj,
    required this.award,
  });
}

class OngoingMission extends Mission {
  int deadlineDate;
  String deadlineMonth;

  OngoingMission({
    required obj,
    required award,
    required this.deadlineDate,
    required this.deadlineMonth,
  }) : super(obj: obj, award: award);
}

class NewMission extends Mission {
  Label10n desc;
  int duration;

  NewMission({
    required obj,
    required award,
    required this.desc,
    required this.duration,
  }) : super(obj: obj, award: award);
}
