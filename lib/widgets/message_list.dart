import 'package:flutter/material.dart';
import 'message_bubble.dart';

class MessageList extends StatelessWidget {
  final List<Map<String, String>> messages;
  final ScrollController scrollController;

  const MessageList({
    required this.messages,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMe = message['sender'] == 'me';
        return MessageBubble(
          text: message['text']!,
          isMe: isMe,
        );
      },
    );
  }
}
