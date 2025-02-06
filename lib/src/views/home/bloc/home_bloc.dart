import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/src/app/api/customer_api.dart';
import 'package:food_delivery_app/src/app/model/food_item.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_event.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadMenu>(_loadAllMenu);
    on<AddToCart>(_addToCart);
    on<RemoveFromCart>(_removeFromCart);
    on<SearchMenu>(_searchMenu);
  }

  Future<void> _loadAllMenu(LoadMenu event, Emitter<HomeState> emit) async {
    emit(HomeLoading(
        cartItems: state.cartItems)); // Preserve the cart while loading
    try {
      final menuItems = await fetchMenu(event.title);
      final isAds = await CustomerApi.getAds();
      emit(HomeLoaded(menuItems, const [], isAds,
          cartItems: state.cartItems)); // Keep existing cart
    } catch (error) {
      emit(HomeError(error.toString(),
          cartItems: state.cartItems)); // Keep existing cart
    }
  }

  void _addToCart(AddToCart event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final updatedCart = List<FoodItem>.from(state.cartItems)
        ..add(event.foodItem); // Add to cart
      emit(HomeLoaded(
        (state as HomeLoaded).menuItems,
        (state as HomeLoaded).searchItems,
        (state as HomeLoaded).isAds,
        cartItems: updatedCart,
      ));
    }
  }

  void _removeFromCart(RemoveFromCart event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final updatedCart = List<FoodItem>.from(state.cartItems)
        ..remove(event.item); // Remove the item
      emit(HomeLoaded(
        (state as HomeLoaded).menuItems,
        (state as HomeLoaded).searchItems,
        (state as HomeLoaded).isAds,
        cartItems: updatedCart,
      ));
    }
  }

  void _searchMenu(SearchMenu event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      // Filter menu items based on the search query
      final filteredItems = event.query.isEmpty
          ? currentState.menuItems // If no search query, show all items
          : currentState.menuItems
              .where((item) =>
                  item.name.toLowerCase().contains(event.query.toLowerCase()))
              .toList();

      // Emit a new HomeLoaded state with the filtered items
      emit(currentState.copyWith(
        searchItems: filteredItems,
      ));
    }
  }

  Future<List<FoodItem>> fetchMenu(String title) async {
    // Example API call to fetch food items (replace with your actual implementation)
    return await CustomerApi.getFood(title);
  }
}
