import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wimf/tabs/tab_main.dart';
import 'package:wimf/tabs/tab_userpage.dart';
import 'package:wimf/tabs/tab_recipes.dart';


class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  _IndexScreenState createState() {
    return _IndexScreenState();
  }
}

class _IndexScreenState extends State<IndexScreen> {

  int _currentIndex = 0;

  final List<Widget> tabs = [
    TabRecipes(),
    TabMain(),
    TabUserpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: 'Fridge'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Recipe'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      body: tabs[_currentIndex],
    );
  }
}