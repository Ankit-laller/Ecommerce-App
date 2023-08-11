
import 'package:ecommerceapp/screens/homepage.dart';
import 'package:ecommerceapp/screens/loginPage.dart';
import 'package:ecommerceapp/screens/provider/login_provider.dart';
import 'package:ecommerceapp/screens/provider/signUp_provider.dart';
import 'package:ecommerceapp/screens/signUpPage.dart';
import 'package:ecommerceapp/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

      default :return null;
    }

  }
}