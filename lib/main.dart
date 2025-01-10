import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/ranking_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pageWidget = [ChatScreen(), RankingScreen()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("みんなで親父ギャグ"),
          ),
          body: _pageWidget.elementAt(_currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "ホーム"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "ランキング"),
            ],
            currentIndex: _currentIndex,
            fixedColor: Colors.blueAccent,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                _currentIndex = index; // タップされたインデックスに更新
              });
            },
          )),
    );
  }
}
