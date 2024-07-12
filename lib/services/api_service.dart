// lib/services/api_service.dart
import 'dart:convert';
import 'package:dattingapp_flutter/models/chat.dart';
import 'package:dattingapp_flutter/models/conversation.dart';
import 'package:dattingapp_flutter/models/create_message.dart';
import 'package:dattingapp_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://localhost:8000/api'; // Adjust this URL to match your API base URL

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String?> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout(String token) async {
    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<List<Chat>> fetchChats(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/chat'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Chat.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Chat');
    }
  }

  Future<List<Conversation>> fetchConversations(
      int chatId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/message/$chatId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Conversation> result =
          body.map((dynamic item) => Conversation.fromJson(item)).toList();
      return result;
    } else {
      throw Exception('Failed to load Conversation');
    }
  }

  Future<User> fetchUser(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/random'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return User.fromJson(body);
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<Conversation> createConversation(CreateMessage message, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/message'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode == 201) {
      return Conversation.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to create Message');
    }
  }

  Future<Chat> createChat(int receiverId, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, int>{
        'receiver_id': receiverId,
      }),
    );

    if (response.statusCode == 201) {
      return Chat.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to create chat');
    }
  }
}
