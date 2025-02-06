import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/app/model/menu_list.dart';
import 'package:food_delivery_app/src/app/theme/app_color.dart';

class CustomMenuWidget extends StatelessWidget {
  const CustomMenuWidget({super.key, required this.isSelected, required this.menuListItem});

  final bool isSelected;
  final MenuList menuListItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeInOut,
          top: isSelected ? 0 : 10, // Adjust for sliding effect
          child: Container(
            height: 95,
            width: 70,
            decoration: BoxDecoration(
              color: isSelected ? AppColor.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   Icons.local_pizza,
                //   color: isSelected ? Colors.white : Colors.grey,
                // ),
                Image.asset(menuListItem.iconPath,width: 50,),
                const SizedBox(height: 5),
                Text(
                  menuListItem.title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
