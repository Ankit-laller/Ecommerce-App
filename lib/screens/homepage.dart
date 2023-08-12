
import 'package:flutter/material.dart';
import 'package:ecommerceapp/screens/FeedScreen.dart';
import 'package:ecommerceapp/screens/CategoryScreen.dart';
import 'package:ecommerceapp/screens/ProfileScreen.dart';
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
    return  Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("ECommerce App",),
        actions:const [
          IconButton(icon: Icon(Icons.notifications, color: Colors.black,),
            onPressed: null,  ),
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
    );
  }
}
