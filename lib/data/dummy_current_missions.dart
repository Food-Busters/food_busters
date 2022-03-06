// 🌎 Project imports:
import "package:food_busters/data/delay.dart";
import "package:food_busters/models/label10n.dart";
import "package:food_busters/models/mission.dart";

Future<List<OngoingMission>> getCurrentMissions() async {
  await serverRequest();

  return [
    OngoingMission(
      obj: Label10n(
        en: "Eat vegetable at least 400g for 4 days",
        th: "กินผักอย่างน้อย 400g เป็นเวลา 4 วัน",
      ),
      award: 200,
      deadlineDate: 12,
      deadlineMonth: "Nov",
    ),
    OngoingMission(
      obj: Label10n(
        en: "Eat at most 220g daily for 1 week",
        th: "กินอาหารไม่เกิน 220g ต่อวันเป็นเวลา 1 สัปดาห์",
      ),
      award: 180,
      deadlineDate: 17,
      deadlineMonth: "Nov",
    ),
  ];
}
