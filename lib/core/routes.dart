
import 'package:ecommerceapp/cubit/category-product/category-product-cubit.dart';
import 'package:ecommerceapp/cubit/product/product_cubit.dart';
import 'package:ecommerceapp/data/models/category/category_model.dart';
import 'package:ecommerceapp/data/models/product_model.dart';
import 'package:ecommerceapp/screens/cart_scrren.dart';
import 'package:ecommerceapp/screens/homepage.dart';
import 'package:ecommerceapp/screens/loginPage.dart';
import 'package:ecommerceapp/screens/my-orders.dart';
import 'package:ecommerceapp/screens/product_deail.dart';
import 'package:ecommerceapp/screens/provider/login_provider.dart';
import 'package:ecommerceapp/screens/provider/order-provider.dart';
import 'package:ecommerceapp/screens/provider/signUp_provider.dart';
import 'package:ecommerceapp/screens/signUpPage.dart';
import 'package:ecommerceapp/screens/splash_screen.dart';
import 'package:ecommerceapp/screens/test-file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../screens/category-product-page.dart';
import '../screens/edit-profile-screen.dart';
import '../screens/order-placed-scrren.dart';
import '../screens/order-scrren.dart';
class Routes{
  static Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case LoginPage.routeName : return CupertinoModalPopupRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (context)=> LoginProvider(context),
            child: const LoginPage())
      );
      case SignUpPage.routeName : return CupertinoModalPopupRoute(
          builder: (context)=> ChangeNotifierProvider(
              create: (context)=> SignUpProvider(context),
              child: const SignUpPage()));
      case HomePage.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> HomePage());
      case SplashScreen.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> SplashScreen());

      case ProductDetailScreen.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> ProductDetailScreen(
            productModel: settings.arguments as ProductModel,
          ));
      case CartScreen.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> CartScreen());
      case CategoryProductPage.routeName: return CupertinoPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => CategoryProductCubit(settings.arguments as CategoryModel),
              child: const CategoryProductPage()
          )
      );
      case EditProfileScreen.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> EditProfileScreen());

      case OrderScreen.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> ChangeNotifierProvider(
              create: (context)=> OrderDetailProvider(),
              child: OrderScreen()));

      case OrderPlacedScreen.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> OrderPlacedScreen());

      case MyOrderScreen.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> MyOrderScreen());

      case Test.routeName :return CupertinoModalPopupRoute(
          builder: (context)=> Test());
      default :return null;
    }

  }
}
