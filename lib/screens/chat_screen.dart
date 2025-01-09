import 'package:flutter/material.dart';
import '../widgets/message_list.dart';
import '../widgets/message_input.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'sender': _messages.length % 2 == 0 ? 'me' : 'other',
      });
    });

    // リストを下までスクロール
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat UI')),
      body: Column(
        children: [
          Expanded(
            child: MessageList(
              messages: _messages,
              scrollController: _scrollController,
            ),
          ),
          MessageInput(
            onSend: _sendMessage,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
