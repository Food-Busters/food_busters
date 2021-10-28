import "package:food_busters/models/buster.dart";

Future<List<Buster>> getTopBustersData() async {
  // * Simulate Server Request
  await Future.delayed(
    const Duration(milliseconds: 1000),
  );

  return [
    Buster(
      username: "no_pollution_pls",
      pfp:
          "https://image.shutterstock.com/image-vector/no-carbon-dioxide-emissions-into-260nw-1685508094.jpg",
      actualRank: 1,
      percentileRank: 94,
    ),
    Buster(
      username: "saladLover",
      pfp:
          "https://img.wongnai.com/p/1920x0/2017/10/23/baa1e676f2604bef87d2d984103e7e8a.jpg",
      actualRank: 2,
      percentileRank: 88,
    ),
    Buster(
      username: "CaffeMocha",
      pfp:
          "https://64.media.tumblr.com/1afca247415c0ded1f04a5fe9f167de1/tumblr_ox2pjl9uuE1uctmvwo8_1280.png",
      actualRank: 3,
      percentileRank: 86,
    ),
  ];
}
