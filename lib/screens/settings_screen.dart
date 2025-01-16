import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = [
      _menuItem("通知設定", Icon(Icons.settings)),
      _menuItem("名前とアイコンの変更", Icon(Icons.settings)),
      _menuItem("プライバシーポリシー", Icon(Icons.settings)),
      _menuItem("利用規約", Icon(Icons.settings)),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text('設定画面'),
        ),
        body: ListView(children: list));
  }

  Widget _menuItem(String title, Icon icon) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
            border:
                new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: icon,
            ),
            Text(title, style: TextStyle(color: Colors.black, fontSize: 18.0))
          ],
        ),
      ),
      onTap: () {
        print("$title");
      },
    );
  }
}
