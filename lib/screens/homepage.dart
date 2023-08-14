
import 'package:ecommerceapp/cubit/cart/cart_cubit.dart';
import 'package:ecommerceapp/cubit/user_state.dart';
import 'package:ecommerceapp/screens/cart_scrren.dart';
import 'package:ecommerceapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/screens/FeedScreen.dart';
import 'package:ecommerceapp/screens/CategoryScreen.dart';
import 'package:ecommerceapp/screens/ProfileScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart/cart_state.dart';
import '../cubit/user_cubit.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName ="Home";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex=0;
  List<Widget> screens = const[
    FeedScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return  BlocListener<UserCubit, UserState>(
      listener: (context, state){
          if( state is UserLoggedOutState){
            Navigator.pushReplacementNamed(context, SplashScreen.routeName);
          }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("ECommerce App",),
          actions: [
            IconButton(
              icon:
            BlocBuilder<CartCubit, CartState>(
              builder: (context,state) {
                return Badge(
                  isLabelVisible: (state is CartLoadingState)? false: true,
                    child: Icon(Icons.shopping_cart, color: Colors.black,),
                    label: Text(state.items.length.toString(),
                ),
                );
              }
            ),
              onPressed: (){
              Navigator.pushNamed(context, CartScreen.routeName);
              },  ),
            SizedBox(width: 10,)
          ],
        ),
        body:screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.category),
                label: "Category"),
            BottomNavigationBarItem(icon: Icon(Icons.person),
                label: "Profile")
          ],
        ),
      ),
    );
  }
}
