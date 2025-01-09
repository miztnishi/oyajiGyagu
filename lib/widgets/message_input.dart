import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const MessageInput({
    required this.controller,
    required this.onSend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              onSend(controller.text);
              controller.clear();
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
