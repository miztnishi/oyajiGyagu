import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/ranking_screen.dart';

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("みんなで親父ギャグ"),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.list), text: "投稿リスト"),
            Tab(icon: Icon(Icons.star), text: "ランキング"),
          ]),
        ),
        body: TabBarView(children: [ChatScreen(), RankingScreen()]),
      ),
    );
  }
}
