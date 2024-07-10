import 'package:flutter/material.dart';

class ConversationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatDetailArguments args =
        ModalRoute.of(context)!.settings.arguments as ChatDetailArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ConversationBubble(
            isSender: index % 2 == 0,
            message: 'Message ${index + 1}',
            time: '12:34 PM',
          );
        },
      ),
    );
  }
}

class ChatDetailArguments {
  final String name;
  final String message;
  final String time;

  ChatDetailArguments({required this.name, required this.message, required this.time});
}

class ConversationBubble extends StatelessWidget {
  final bool isSender;
  final String message;
  final String time;

  ConversationBubble(
      {required this.isSender, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender)
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://www.biography.com/.image/t_share/MTc5MDEyODkyMzYzMDI0MzYz/file.jpg',
              ),
              radius: 20.0,
            ),
          Container(
            decoration: BoxDecoration(
              color: isSender ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isSender ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: isSender ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (isSender)
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://www.biography.com/.image/t_share/MTc5MDEyODkyMzYzMDI0MzYz/file.jpg',
              ),
              radius: 20.0,
            ),
        ],
      ),
    );
  }
}
