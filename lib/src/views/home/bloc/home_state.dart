part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<FoodItem> cartItems;

  const HomeState({this.cartItems = const []});
}

final class HomeInitial extends HomeState {
  const HomeInitial() : super();
}

class HomeLoading extends HomeState {
  const HomeLoading({List<FoodItem> cartItems = const []})
      : super(cartItems: cartItems);
}

class HomeLoaded extends HomeState {
  final List<FoodItem> menuItems;
  final List<FoodItem> searchItems;
  final bool isAds;

  HomeLoaded(this.menuItems, this.searchItems, this.isAds,
      {List<FoodItem> cartItems = const []})
      : super(cartItems: cartItems);

  HomeLoaded copyWith({
    List<FoodItem>? menuItems,
    bool? isAds,
    List<FoodItem>? searchItems,
    List<FoodItem>? cartItems,
  }) {
    return HomeLoaded(
      menuItems ?? this.menuItems,
      searchItems ?? this.searchItems,
      isAds ?? this.isAds,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message, {List<FoodItem> cartItems = const []})
      : super(cartItems: cartItems);
}
