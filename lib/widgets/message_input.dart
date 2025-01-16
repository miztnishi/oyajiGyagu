import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const MessageInput({
    required this.controller,
    required this.onSend,
    Key? key,
  }) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller, // ウィジェットから取得
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (widget.controller.text.trim().isNotEmpty) {
                widget.onSend(widget.controller.text.trim()); // メッセージを送信
                widget.controller.clear(); // テキストフィールドをクリア
              }
            },
            child: const Text('Send'),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.controller.text.trim().isNotEmpty
                  ? Colors.blue
                  : Colors.grey, // ボタンの色を動的に変更
              foregroundColor: Colors.white, // ボタンの色を動的に変更
            ),
          ),
        ],
      ),
    );
  }
}
