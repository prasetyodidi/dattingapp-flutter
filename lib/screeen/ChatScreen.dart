import 'package:dattingapp_flutter/screeen/ConversationScreen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ChatMessage(
            name: ['Stacy Candice', 'Jeniffer Canning', 'Lara Langford', 'Sara Canning', 'Emy Dawson'][index],
            message: ['haloo, salam kenal', 'selamat siang', 'selamat siang', 'selamat siang', 'selamat siang'][index],
            time: ['1 min ago', '1 hr ago', '1 day ago', '2 day ago', '3 day ago'][index],
          );
        },
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  ChatMessage({required this.name, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(
          context, 
          '/conversation', 
          arguments: ChatDetailArguments(
                  name: name,
                  message: message,
                  time: time,
                ))
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.biography.com/.image/t_share/MTc5MDEyODkyMzYzMDI0MzYz/file.jpg'),
              radius: 25.0,
              
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(message),
                SizedBox(height: 5.0),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}