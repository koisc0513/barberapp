import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/auth_provider.dart'; // Import AuthProvider
import 'package:untitled/screens/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUser = authProvider.currentUser; // Lấy thông tin người dùng từ authProvider

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Center(child: Text("User not logged in.")),
      );
    }

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
              "Name: ${currentUser['name'] ?? 'N/A'}", // Hiển thị tên người dùng
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Email: ${currentUser['email'] ?? 'N/A'}", // Hiển thị email người dùng
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Phone: ${currentUser['phone'] ?? 'N/A'}", // Hiển thị số điện thoại người dùng
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Gender: ${currentUser['gender'] ?? 'N/A'}", // Hiển thị giới tính người dùng
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
