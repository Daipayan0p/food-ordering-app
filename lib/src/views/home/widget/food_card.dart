import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/src/app/const/constants.dart';
import 'package:food_delivery_app/src/app/model/food_item.dart';
import 'package:food_delivery_app/src/app/theme/app_color.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_bloc.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_event.dart';
import 'package:food_delivery_app/src/views/home/widget/expandable_cart_sheet.dart';

class FoodCard extends StatelessWidget {
  final FoodItem item;

  const FoodCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * 0.45, // Dynamic width based on parent
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Stack(children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.png',
                    // Path to the placeholder image
                    image: item.imgUrl,
                    // The network image URL
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: constraints.maxWidth * 0.8,
                    // Maintain aspect ratio
                    placeholderFit: BoxFit.fitWidth,
                    // Ensures the placeholder matches the fit
                    imageErrorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      // Fallback if the image fails to load
                      return Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                        height: constraints.maxWidth * 0.8,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      decoration: const BoxDecoration(color: AppColor.white),
                      child: Image.asset(
                        item.type == "veg"
                            ? "$baseImagePath/veg.png"
                            : "$baseImagePath/non-veg.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // const SizedBox(height: 4),
                    // Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs. ${item.price}",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<HomeBloc>().add(AddToCart(item));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              // Button background color
                              borderRadius: BorderRadius.circular(8),
                              // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  // Subtle shadow
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
