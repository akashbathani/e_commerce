import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/bloc/cart/add_cart/add_cart_bloc.dart';
import 'package:e_commerce/bloc/cart/delete/delete_cart_bloc.dart';
import 'package:e_commerce/bloc/cart/view_cart/view_cart_bloc.dart';
import 'package:e_commerce/bloc/category/category_bloc.dart';
import 'package:e_commerce/bloc/order/order_bloc.dart';
import 'package:e_commerce/bloc/product/product_bloc.dart';
import 'package:e_commerce/bloc/profile/profile_bloc.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(apiService: ApiService())),
        BlocProvider(
          create: (context) => ProfileBloc(apiService: ApiService()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(apiService: ApiService()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(apiService: ApiService()),
        ),
        BlocProvider(
          create: (context) => AddCartBloc(apiService: ApiService()),
        ),
        BlocProvider(create: (context) => OrderBloc(apiService: ApiService())),
        BlocProvider(
          create: (context) => ViewCartBloc(apiService: ApiService()),
        ),
        BlocProvider(
          create: (context) => DeleteCartBloc(apiService: ApiService()),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'mainFont'),
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData.dark(),
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
