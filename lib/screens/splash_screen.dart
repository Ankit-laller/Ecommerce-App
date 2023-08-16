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
    Timer(const Duration(milliseconds: 300), () {
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
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(51.0, 70.0, 0.0, 0.0),
                child: Center(
                  child: Text('Find your Gadget',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 65.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.center,
                          end: FractionalOffset.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: const Image(
                          image: AssetImage('assets/images/splash.png'),
                          fit: BoxFit.contain))),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.white,
              //     onPrimary: const Color(0xff5956E9),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 80,
              //       vertical: 22,
              //     ),
              //     textStyle: const TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              //   onPressed: () {
              //     Navigator.pushReplacementNamed(context, "auth");
              //   },
              //   child: const Text('Get Started'),
              // )
            ],
          ),
        ),
      )
    );
  }
}
