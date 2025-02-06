import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/app/theme/app_theme.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_bloc.dart';
import 'package:food_delivery_app/src/views/home/bloc/home_event.dart';
import 'package:food_delivery_app/src/views/home/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(LoadMenu("All")),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home:   HomeView(),
      ),
    );
  }
}

