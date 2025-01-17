import 'package:flutter/material.dart';

class MessageGrid extends StatefulWidget {
  @override
  _MessageGridState createState() => _MessageGridState();
}

// 型を作りたい
// {String "text", int "likes", bool "isLiked"},
class typeMessage {
  String text;
  int likes;
  bool isLiked;

  typeMessage({
    required this.text,
    required this.likes,
    required this.isLiked,
  });
}

class _MessageGridState extends State<MessageGrid>
    with TickerProviderStateMixin {
  final List<typeMessage> jokes = [
    typeMessage(text: "テスト1", likes: 0, isLiked: false),
    typeMessage(text: "テスト2", likes: 0, isLiked: false),
    typeMessage(text: "テスト3", likes: 0, isLiked: false),
    typeMessage(text: "テスト4", likes: 0, isLiked: false),
    typeMessage(text: "テスト5", likes: 0, isLiked: false),
    typeMessage(text: "テスト6", likes: 0, isLiked: false),
    typeMessage(text: "テスト7", likes: 0, isLiked: false),
    typeMessage(text: "テスト8", likes: 0, isLiked: false),
    typeMessage(text: "テスト9", likes: 0, isLiked: false),
    typeMessage(text: "テスト10", likes: 0, isLiked: false),
    typeMessage(text: "テスト11", likes: 0, isLiked: false),
  ];

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  late List<Offset> _positions;
  final List<GlobalKey> _keys = []; // GlobalKey を各カードに割り当てる
  late List<double> _opacities = []; // カードの透明度の設定、タップされたカードが0になる

  var _entry;
  void _onDoubleTap(int index, double CenterX, double CenterY, context,
      overlayState, screenSize) {
    setState(() {
      _opacities = List.generate(jokes.length, (_) => 1.0);

      _opacities[index] = 0.3;
    });
    // カードのキーを取得
    final key = _keys[index];
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;

    // グローバル座標を取得
    final Offset globalPosition = renderBox.localToGlobal(Offset.zero);
//サイズを取得
    final Size size = renderBox.size;
    setState(() {
      // 指定されたカードの位置を移動
      // _positions[index] = Offset(CenterX - (globalPosition.dx + size.width / 2),
      //     CenterY - (globalPosition.dy + size.height / 2)); // 任意の移動量
    });

    _entry = makeOverlay(context, screenSize, CenterX, CenterY);
    overlayState?.insert(_entry);

    // // 一定時間後に元の位置に戻す
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //     _positions[index] = Offset.zero;
    //   });
    // });
  }

  void removeEntry() {
    if (_entry != null) {
      _entry!.remove();
      _entry = null;
    }
  }

  OverlayEntry makeOverlay(
    BuildContext context,
    screenSize,
    x,
    y,
  ) {
    return OverlayEntry(
        builder: (BuildContext context) => Positioned(
              width: screenSize.width,
              height: screenSize.height,
              left: 0,
              top: 0,
              child: Opacity(
                  opacity: 0.5,
                  child: GestureDetector(
                    onTap: removeEntry,
                    child: Container(
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          "Overlay",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )),
            ));
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      jokes.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );

    _positions = List.generate(jokes.length, (_) => Offset.zero);
    _keys.addAll(List.generate(jokes.length, (_) => GlobalKey()));
    _opacities = List.generate(jokes.length, (_) => 1.0);

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 1.0, end: 1.5).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleTap(int index) {
    setState(() {
      jokes[index].isLiked = !jokes[index].isLiked;

      // いいね数を増加
      jokes[index].likes = jokes[index].isLiked
          ? jokes[index].likes - 1
          : jokes[index].likes + 1;
    });

    // 対象のアイテムだけアニメーションを実行
    _controllers[index].forward().then((_) {
      _controllers[index].reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // 画面サイズを取得
    final centerX = screenSize.width / 2; // 横方向の中心
    final centerY = screenSize.height / 2; // 縦方向の中心
    final OverlayState? overlayState = Overlay.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 2列
            crossAxisSpacing: 8.0, // 列間のスペース
            mainAxisSpacing: 8.0, // 行間のスペース
            childAspectRatio: 1.0, // アスペクト比
          ),
          itemCount: jokes.length,
          itemBuilder: (context, index) {
            final joke = jokes[index];
            return Opacity(
                opacity: _opacities[index],
                child: GestureDetector(
                  onDoubleTap: () => _onDoubleTap(index, centerX, centerY,
                      context, overlayState, screenSize), // タップ時の処理
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: Matrix4.translationValues(
                        _positions[index].dx, _positions[index].dy, 0),
                    // child: Opacity(
                    //   opacity: _opacities[index],
                    child: Card(
                      key: _keys[index],
                      color: Colors.amber[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${joke.text}, ${_opacities[index]}",
                              maxLines: 3, // 最大2行まで表示
                              overflow: TextOverflow.ellipsis, // 長い場合は省略
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: ScaleTransition(
                                      scale: _animations[index],
                                      child: const Icon(Icons.favorite,
                                          color: Colors.red),
                                    ),
                                    onTap: () => _handleTap(index),
                                  ),
                                  Text(" ${joke.likes}"),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // ),
                ));
          },
        ),
      ),
    );
  }
}
