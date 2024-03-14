import 'package:flutter/material.dart';
import 'package:tarea_6/Wordpress.dart';
import 'package:tarea_6/about.dart';
import 'package:tarea_6/contryUniversity.dart';
import 'package:tarea_6/guessMyAge.dart';
import 'package:tarea_6/guessMyGender.dart';
import 'package:tarea_6/weather.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;

  final List<Widget> _pages = [
    HomeWidget(),
    guessMyGender(),
    guessMyAge(),
    contryUniversity(),
    weather(),
    Wordpress(),
    about(),
    guessMyGender(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        type: _bottomNavType,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Images/caja_herramientas.png',
              width: 300,
              height: 180,
            ),
            SizedBox(height: 20),
            Text(
              '¡Esta aplicación es multiusos\ncomo una caja de herramientas!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.female_outlined),
    activeIcon: Icon(Icons.male_rounded),
    label: 'Guess My Gender',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.baby_changing_station_outlined),
    activeIcon: Icon(Icons.baby_changing_station_rounded),
    label: 'Guess My Age',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.assignment_ind_outlined),
    activeIcon: Icon(Icons.assignment_ind_rounded),
    label: 'University',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.sunny_snowing),
    activeIcon: Icon(Icons.sunny_snowing),
    label: 'Weather',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.web_outlined),
    activeIcon: Icon(Icons.web_rounded),
    label: 'Wordpress',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline_rounded),
    activeIcon: Icon(Icons.person_rounded),
    label: 'About',
  ),
];
