import "package:food_busters/data/delay.dart";
import "package:food_busters/models/restaurant_menu.dart";

Future<List<RestaurantMenu>> getRestaurantData() async {
  await serverRequest();

  return [
    RestaurantMenu(
      menuName: "AVOCADON",
      restaurantName: "cp best",
      menuPicture:
          "https://hips.hearstapps.com/hmg-prod/images/avocado-salad-1524672116.png",
      price: 170,
      points: 399,
      healthiness: 2,
      cheaper: 25,
      lessCarbon: 41,
      match: 98,
    ),
    RestaurantMenu(
      menuName: "MEGA SALAD",
      restaurantName: "Aroi cusine",
      menuPicture:
          "https://img.wongnai.com/p/1920x0/2017/10/23/baa1e676f2604bef87d2d984103e7e8a.jpg",
      price: 200,
      points: 429,
      healthiness: 3,
      cheaper: 18,
      lessCarbon: 20,
      match: 80,
    ),
    RestaurantMenu(
      menuName: "Caffè Cappuccino",
      restaurantName: "Rabbit House",
      menuPicture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHgwfgYIN2UMP3_auhwsJnOAow2lmXlj_7EQ&usqp=CAU",
      price: 290,
      points: 690,
      healthiness: 1,
      cheaper: -69,
      lessCarbon: -420,
      match: 420,
    ),
  ];
}
