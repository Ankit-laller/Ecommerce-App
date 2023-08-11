import 'dart:async';

import 'package:ecommerceapp/core/ui.dart';
import 'package:ecommerceapp/cubit/user_cubit.dart';
import 'package:ecommerceapp/cubit/user_state.dart';
import 'package:ecommerceapp/screens/homepage.dart';
import 'package:ecommerceapp/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName ="Splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      goToNextScreen();
    });
  }
  void goToNextScreen() {
    UserState userState = BlocProvider.of<UserCubit>(context).state;
    if(userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
    else if(userState is UserLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
    else if(userState is UserErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        goToNextScreen();
      },
      child: const Scaffold(
        body: Center(
            child: CircularProgressIndicator()
        ),
      ),
    );
  }
}
