import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/src/app/model/food_item.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_bloc.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_event.dart';

class TotalViewBottomSheet extends StatelessWidget {
  const TotalViewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        // Group cart items by name and calculate quantities
        final Map<String, Map<String, dynamic>> groupedCart = {};
        for (var item in state.cartItems) {
          if (groupedCart.containsKey(item.name)) {
            groupedCart[item.name]!['quantity']++;
            groupedCart[item.name]!['totalPrice'] += item.price;
          } else {
            groupedCart[item.name] = {
              'foodItem': item,
              'quantity': 1,
              'totalPrice': item.price,
            };
          }
        }

        // Calculate the total price
        final double totalPrice = groupedCart.values
            .fold(0.0, (sum, entry) => sum + entry['totalPrice']);

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: size * 0.065,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: const NetworkImage(
                        "https://www.w3schools.com/w3images/avatar2.png",
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Amount",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Rs. ${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: groupedCart.isEmpty
                      ? null
                      : () {
                          // Handle checkout
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            if (groupedCart.isNotEmpty)
              Column(
                children: [
                  const Text(
                    "Cart Items:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...groupedCart.values.map((entry) {
                    final item = entry['foodItem'] as FoodItem;
                    final quantity = entry['quantity'] as int;
                    final itemTotal = entry['totalPrice'] as double;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${item.name} (x$quantity)",
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(RemoveFromCart(
                                  item)); // Dispatch remove event
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                            ),
                          ),

                          Text(
                            "Rs. ${itemTotal.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(AddToCart(
                                  item)); // Dispatch remove event
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
          ],
        );
      },
    );
    ();
  }
}
