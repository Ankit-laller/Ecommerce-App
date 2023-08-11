import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerceapp/core/routes.dart';
import 'package:ecommerceapp/core/ui.dart';
import 'package:ecommerceapp/cubit/user_cubit.dart';
import 'package:ecommerceapp/screens/splash_screen.dart';


void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: Themes.defaultTheme,
        onGenerateRoute: Routes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Change in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
