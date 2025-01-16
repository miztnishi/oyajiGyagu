import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final String senderName;
  final bool isMe;

  const MessageBubble({
    required this.text,
    required this.senderName,
    required this.isMe,
    Key? key,
  }) : super(key: key);

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  String? _selectedReaction; // 選択されたリアクション

  void _showReactionPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => _selectReaction("👍"),
                icon: Text("👍", style: TextStyle(fontSize: 24)),
              ),
              IconButton(
                onPressed: () => _selectReaction("❤️"),
                icon: Text("❤️", style: TextStyle(fontSize: 24)),
              ),
              IconButton(
                onPressed: () => _selectReaction("😂"),
                icon: Text("😂", style: TextStyle(fontSize: 24)),
              ),
              IconButton(
                onPressed: () => _selectReaction("😮"),
                icon: Text("😮", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectReaction(String reaction) {
    setState(() {
      if (reaction == _selectedReaction) {
        _selectedReaction = null;
      } else {
        _selectedReaction = reaction;
      }
    });
    Navigator.pop(context); // モーダルを閉じる
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!widget.isMe) ...[
              // 他の人の投稿にはアイコンを表示
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  widget.senderName[0], // 送信者名の最初の文字
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8), // アイコンとメッセージバブルの間のスペース
            ],
            Flexible(
              child: Stack(
                clipBehavior: Clip.none, // 子要素がはみ出しても表示
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // 名前とメッセージを左揃え
                    children: [
                      if (!widget.isMe)
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0), // アイコンとのスペース
                          child: Text(
                            widget.senderName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: widget.isMe
                                  ? Colors.blue[200]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              onLongPress: () => !widget.isMe
                                  ? _showReactionPicker(context)
                                  : null,
                              child: Text(
                                widget.text,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          if (_selectedReaction != null)
                            Positioned(
                              bottom: -10, // メッセージバブルの下に配置
                              right: 0, // メッセージバブルの右端に合わせる
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(80),
                                  // border: Border.all(color: Colors.white),
                                ),
                                padding: const EdgeInsets.all(1),
                                child: Text(
                                  _selectedReaction!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            if (_selectedReaction != null) const SizedBox(height: 30), // 下方向の余白
            if (widget.isMe) const SizedBox(width: 8), // 自分の投稿の右余白
          ],
        ),
      ],
    );
  }
}
