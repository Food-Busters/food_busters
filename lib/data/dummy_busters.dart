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
    Buster(
      username: "Speedwagon420",
      pfp:
          "https://cdn.myanimelist.net/r/360x360/images/characters/7/196031.jpg?s=1c554a3e9004301e185ef141f6f7c1d9",
      actualRank: 4,
      percentileRank: 85,
    ),
    Buster(
      username: "ILikeDonut",
      pfp:
          "https://www.online-station.net/wp-content/uploads/2020/02/JoJo1200_1200_628.jpg",
      actualRank: 5,
      percentileRank: 82,
    ),
  ];
}

Future<List<Buster>> getFriendsData() async {
  // * Simulate Server Request
  await Future.delayed(
    const Duration(milliseconds: 1000),
  );

  return [
    Buster(
      username: "CaffeMocha",
      pfp:
          "https://64.media.tumblr.com/1afca247415c0ded1f04a5fe9f167de1/tumblr_ox2pjl9uuE1uctmvwo8_1280.png",
      actualRank: 3,
      percentileRank: 86,
    ),
    Buster(
      username: "THEWORLD",
      pfp:
          "https://pbs.twimg.com/profile_images/1164228011194892288/w2P19BSw_400x400.jpg",
      actualRank: 42,
      percentileRank: 69,
    ),
    Buster(
      username: "NeverGonnaGiveEnvironmentUp",
      pfp:
          "https://i.gadgets360cdn.com/large/rick_astley_youtube_1627540038486.jpg?downsize=950:*",
      actualRank: 128,
      percentileRank: 22,
    ),
    Buster(
      username: "ILoveDonut",
      pfp:
          "https://s.isanook.com/ga/0/rp/r/w850/ya0xa0m1w0/aHR0cHM6Ly9zLmlzYW5vb2suY29tL2dhLzAvdWQvMjIwLzExMDIzNjkvZGVtb25fc2xheWVyX2tpbWV0c3VfeWFpYmFfcmUuanBn.jpg",
      actualRank: 255,
      percentileRank: 2,
    ),
  ];
}
