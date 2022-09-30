import 'package:beapp_exercice/presentation/pages/home.dart';
import 'package:beapp_exercice/presentation/pages/search.dart';
import 'package:beapp_exercice/presentation/styles/colors.dart';
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
            50: AppColors.mainBlue,
            100: AppColors.mainBlue,
            200: AppColors.mainBlue,
            300: AppColors.mainBlue,
            400: AppColors.mainBlue,
            500: AppColors.mainBlue,
            600: AppColors.mainBlue,
            700: AppColors.mainBlue,
            800: AppColors.mainBlue,
            900: AppColors.mainBlue,
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
            selectedItemColor: AppColors.mainBlue,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.map, key: Key('First')),
                label:  "Plan"),
              BottomNavigationBarItem(
                icon: Icon(Icons.list, key: Key('Second')),
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
