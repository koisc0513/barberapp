import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/auth_provider.dart'; // Import AuthProvider

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.userName; // Lấy tên người dùng từ authProvider

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authProvider.logout(); // Không cần đợi kết quả từ logout
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${userName ?? 'N/A'}", // Hiển thị tên người dùng
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Email: ${authProvider.user ?? 'N/A'}", // Hiển thị email người dùng
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to edit profile screen or other action
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
