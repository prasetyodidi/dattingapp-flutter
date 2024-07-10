import 'package:flutter/material.dart';

class TinderingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with icons
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.local_fire_department),
                    color: Colors.red,
                    onPressed: () {
                      // Handle flame button press
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                  ),
                ],
              ),
            ),
            // Profile picture and details
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                          'assets/profile_image.png'), // replace with your image asset
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Jon, 24',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text('Photographer'),
                  ],
                ),
              ),
            ),
            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red, size: 40),
                    onPressed: () {
                      // Handle dislike button press
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.star, color: Colors.blue, size: 40),
                    onPressed: () {
                      // Handle super like button press
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.green, size: 40),
                    onPressed: () {
                      // Handle like button press
                    },
                  ),
                ],
              ),
            ),
            // Bottom bar with buttons
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Tinder Gold button press
                    },
                    child: Text('GET TINDER GOLD'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Tinder Plus button press
                    },
                    child: Text('GET TINDER PLUS'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
