import 'package:food_delivery_app/src/app/model/menu_list.dart';

// String BASEURL = "http://127.0.0.1:8081";
String BASEURL = "https://cfd0-110-224-91-54.ngrok-free.app";

String baseImagePath = "assets/images";

List<MenuList> allMenuList = [
  MenuList("All", "$baseImagePath/all.png"),
  MenuList("Pizza", "$baseImagePath/pizza.png"),
  MenuList("Burger", "$baseImagePath/burger.png"),
  MenuList("Pasta", "$baseImagePath/pasta.png"),
  MenuList("Snacks", "$baseImagePath/snacks.png"),
];
