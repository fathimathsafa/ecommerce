import 'package:demo/fake_store/presentation/bottom.dart';
import 'package:demo/fake_store/presentation/bottom_controller.dart';
import 'package:demo/fake_store/presentation/cart_contrller.dart';
import 'package:demo/fake_store/presentation/category_controller.dart';
import 'package:demo/fake_store/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:demo/fake_store/presentation/login_controller.dart';
import 'package:demo/fake_store/presentation/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HomeScreenController(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginController(),
    ),
    ChangeNotifierProvider(
      create: (context) => CartController(),
    ),
    ChangeNotifierProvider(
      create: (context) => CategoryController(),
    ),
    ChangeNotifierProvider(
      create: (context) => BottomNavController(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationScreen(),
    );
  }
}
