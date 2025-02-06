import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_bloc.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_event.dart';
import 'package:food_delivery_app/src/views/profile/profile_page.dart';

import '../../../app/theme/app_color.dart';

class HeaderView extends StatefulWidget {
  const HeaderView({super.key});

  @override
  State<HeaderView> createState() => HeaderViewState();
}

class HeaderViewState extends State<HeaderView> {
  bool isSearchOn = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose Anything",
                  style: headingTextStyle,
                ),
                Text(
                  "you want!",
                  style: headingTextStyle,
                ),
              ],
            ),
            Row(
              children: [
                ClipOval(
                  child: Material(
                    color: AppColor.white,
                    shadowColor: Colors.grey,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSearchOn = !isSearchOn;
                        });
                      },
                      child: SizedBox(
                        width: size * 0.13,
                        height: size * 0.13,
                        child: Icon(
                          Icons.search,
                          size: size * 0.08,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: size * 0.065, // Adjust radius
                    backgroundColor: Colors.grey[200], // Background color
                    backgroundImage: const NetworkImage(
                      "https://www.w3schools.com/w3images/avatar2.png", // Replace with your image URL
                    ),
                    child: const Icon(
                      Icons.person, // Fallback icon
                      size: 30,
                      color: Colors.grey,
                    ), // Displayed if image URL fails
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isSearchOn) _searchArea(context),
      ],
    );
  }

  Widget _searchArea(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.grey,
            size: size * 0.06,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (query) {
                // Update the search query and dispatch the search event to HomeBloc

                // Dispatch the search event to the HomeBloc
                context.read<HomeBloc>().add(SearchMenu(query));
              },
              decoration: InputDecoration(
                hintText: "Search for food, restaurants, or more...",
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle headingTextStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);
