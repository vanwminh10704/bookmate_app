import 'package:flutter/material.dart';
import 'package:book_flutter/pages/main/home_page.dart';
import 'package:book_flutter/pages/main/search_page.dart';
import 'package:book_flutter/pages/main/setting_page.dart';
import 'package:book_flutter/pages/main/favourite_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    SearchPage(),
    FavouritePage(),
    SettingPage()
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 12,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        //type: BottomNavigationBarType.shifting,
        backgroundColor:  Color(0xFFF9F9F9),
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        elevation: 0,
        items: [
          BottomNavigationBarItem(label: 'Home Page', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Search Page', icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: 'Favourite Page', icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label: 'Setting Page', icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}