import 'package:beapp_exercice/presentation/pages/home.dart';
import 'package:beapp_exercice/presentation/pages/search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF087FA3,
          <int, Color>{
            50: Color(0xFF087FA3),
            100: Color(0xFF087FA3),
            200: Color(0xFF087FA3),
            300: Color(0xFF087FA3),
            400: Color(0xFF087FA3),
            500: Color(0xFF087FA3),
            600: Color(0xFF087FA3),
            700: Color(0xFF087FA3),
            800: Color(0xFF087FA3),
            900: Color(0xFF087FA3),
          },
        ),
      ),
      home: const MyHomePage(title: 'Exercice Technique'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final globalKey = GlobalKey<ScaffoldState>();
  final screens = [
    const Home(),
    const Search(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF087FA3),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: "Plan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Liste",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (value) {
              _onItemTapped(value);
            },
          ),
        ),
      ),
    );
  }
}
