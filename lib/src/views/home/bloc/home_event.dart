import 'package:food_delivery_app/src/app/model/food_item.dart';

abstract class HomeEvent {}

class LoadMenu extends HomeEvent {
  final String title;
  LoadMenu(this.title);
}

class AddToCart extends HomeEvent {
  final FoodItem foodItem;

  AddToCart(this.foodItem);
}

class RemoveFromCart extends HomeEvent {
  final FoodItem item;

  RemoveFromCart(this.item);
}

class SearchMenu extends HomeEvent {
  final String query;

  SearchMenu(this.query);
}
