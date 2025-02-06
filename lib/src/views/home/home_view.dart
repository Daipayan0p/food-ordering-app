import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/src/app/model/food_item.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_bloc.dart';
import 'package:food_delivery_app/src/views/home/widget/expandable_cart_sheet.dart';
import 'package:food_delivery_app/src/views/home/widget/food_card.dart';
import 'package:food_delivery_app/src/views/home/widget/header_view.dart';
import 'package:food_delivery_app/src/views/home/widget/menu_list.dart';
import 'package:food_delivery_app/src/views/home/widget/total_view_bottom_sheet.dart';
import 'dart:async';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _shouldShowAds = false;
  StreamSubscription? _homeBlocSubscription;

  @override
  void initState() {
    super.initState();

    // Listen to HomeBloc state changes
    _homeBlocSubscription =
        context.read<HomeBloc>().stream.listen((state) {
          if (state is HomeLoaded) {
            if (_shouldShowAds != state.isAds) {
              setState(() {
                _shouldShowAds = state.isAds;
              });
            }
          }
        });
  }

  @override
  void dispose() {
    _homeBlocSubscription?.cancel(); // Cleanup listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HeaderView(),
                    const SizedBox(height: 10),

                    _shouldShowAds ? _adsSection() : const SizedBox.shrink(),

                    const SizedBox(height: 5),
                    const MenuList(),

                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoaded) {
                          return _foodList(state.searchItems.isNotEmpty
                              ? state.searchItems
                              : state.menuItems);
                        }
                        return const SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),

                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state.cartItems.isNotEmpty) {
                          return const SizedBox(height: 75);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Cart Section
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.cartItems.isNotEmpty) {
                return const ExpandableCartSheet(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [TotalViewBottomSheet()],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _foodList(List<FoodItem> menuList) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: menuList.length,
      itemBuilder: (context, index) {
        return FoodCard(item: menuList[index]);
      },
    );
  }

  Widget _adsSection() {
    return SizedBox(
      height: 190,
      width: double.infinity,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          _adImage(),
          _adImage(),
        ],
      ),
    );
  }

  Widget _adImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          fit: BoxFit.fitWidth,
          "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
        ),
      ),
    );
  }
}
