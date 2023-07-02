import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cakes Category',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF9C8691, {
          50: const Color(0xFFF3E6EB),
          100: const Color(0xFFE2C9D3),
          200: const Color(0xFFD2ACBA),
          300: const Color(0xFFC08E9F),
          400: const Color(0xFFB17387),
          500: const Color(0xFF9C8691),
          600: const Color(0xFFA05962),
          700: const Color(0xFF8C4850),
          800: const Color(0xFF773940),
          900: const Color(0xFF622A30),
        }),
      ),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
    Page5(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0), // Adjust the top and bottom padding here
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 30.0, // Adjust the height of the search input here
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 251, 247, 247),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true, // Reduce the height of the input content
                        contentPadding: EdgeInsets.all(8.0), // Adjust the padding of the input content
                        hintText: 'Search...',
                        fillColor: Color.fromARGB(255, 251, 247, 247),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.category),
                  onPressed: () {
                    // Handle category action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Color(0xFF410101),
        unselectedItemColor: Color.fromARGB(255, 152, 148, 148),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Cakes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.palette_outlined),
            label: 'Cookies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.outdoor_grill_outlined),
            label: 'Condiment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.redeem_sharp),
            label: 'Hamper',
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 3'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 4'),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 5'),
    );
  }
}
