import 'dart:async';

import 'package:dattingapp_flutter/models/conversation.dart';
import 'package:dattingapp_flutter/models/create_message.dart';
import 'package:dattingapp_flutter/providers/auth_provider.dart';
import 'package:dattingapp_flutter/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  final int chatId;
  final int receiverId;

  const ConversationScreen(
      {Key? key, required this.chatId, required this.receiverId})
      : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Conversation> _messages = [
    Conversation(
        id: 1000,
        profileUrl: "https://ui-avatars.com/api/?name=John+Doe",
        createdAt: "11:20",
        message: "hello!",
        isSender: false)
  ];
  bool _isLoading = true;
  bool _hasError = false;
  final apiService = ApiService();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    startPolling();
  }

  void startPolling() {
    const pollInterval =
        Duration(seconds: 2); // Adjust polling interval as needed
    timer = Timer.periodic(pollInterval, (timer) {
      _fetchMessages();
    });
  }

  Future<void> _fetchMessages() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final conversations = await apiService.fetchConversations(
          widget.chatId, authProvider.token!);
      setState(() {
        _messages = conversations;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                Conversation message = _messages[index];
                return ConversationBubble(
                  isSender: message.isSender,
                  message: message.message,
                  time: message.createdAt,
                  profileUrl: message.profileUrl,
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);

              CreateMessage createMessage = CreateMessage(
                  chatId: widget.chatId,
                  message: _messageController.text,
                  receiverId: widget.receiverId);
              await apiService.createConversation(
                  createMessage, authProvider.token!);
              _fetchMessages();
            },
          ),
        ],
      ),
    );
  }
}

class ChatDetailArguments {
  final String name;
  final String message;
  final String time;

  ChatDetailArguments(
      {required this.name, required this.message, required this.time});
}

class ConversationBubble extends StatelessWidget {
  final bool isSender;
  final String message;
  final String time;
  final String profileUrl;

  ConversationBubble(
      {required this.isSender,
      required this.message,
      required this.time,
      required this.profileUrl});

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
                'https://ui-avatars.com/api/?background=0D8ABC&color=fff',
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
                profileUrl,
              ),
              radius: 20.0,
            ),
        ],
      ),
    );
  }
}
