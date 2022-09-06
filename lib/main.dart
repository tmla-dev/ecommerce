import 'package:ecommerce/view_models/auth_provider.dart';
import 'package:ecommerce/view_models/cart_provider.dart';
import 'package:ecommerce/views/home_page.dart';
import 'package:ecommerce/views/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/view_models/product_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      ),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isAuth = context.watch<AuthProvider>().isAuth;
    context.read<AuthProvider>().checkLogin();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce',
      theme: ThemeData(
        primaryColor: const Color(0xFF6962E7),
        accentColor: const Color(0xFFA9A6EA),
        backgroundColor: const Color(0xFFF1EFF6),
      ),
      home: isAuth ? HomePage():SigninPage(),
    );
  }
}

