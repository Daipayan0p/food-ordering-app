import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/src/app/const/constants.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_bloc.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_event.dart';

import 'custom_menu_widget.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Ensure the parent has a fixed height
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10);
        },
        scrollDirection: Axis.horizontal,
        itemCount: allMenuList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                context
                    .read<HomeBloc>()
                    .add(LoadMenu(allMenuList[index].title));
              });
            },
            child: SizedBox(
              width: 80, // Provide fixed width for each item
              child: CustomMenuWidget(
                isSelected: index == selectedIndex,
                menuListItem: allMenuList[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
