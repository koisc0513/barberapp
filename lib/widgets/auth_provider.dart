import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  List<Map<String, String>> _users = []; // List of registered users
  String? _user; // Currently logged-in user's email

  String? get user => _user;

  // Get the current logged-in user's name
  String? get userName {
    final user = _users.firstWhere(
          (user) => user['email'] == _user,
      orElse: () => {},
    );
    return user.isEmpty ? null : user['name'];
  }

  // Check if the user is logged in
  bool get isLoggedIn => _user != null;

  // Register a new user
  Future<void> register(String name, String email, String password, String phone, String gender) async {
    await Future.delayed(Duration(seconds: 2));

    // Check if email already exists
    if (_users.any((user) => user['email'] == email)) {
      throw Exception("Email already exists");
    }

    // Validate gender (must be either 'Nam' or 'Nữ')
    if (gender != 'Nam' && gender != 'Nữ') {
      throw Exception("Gender must be 'Nam' or 'Nữ'");
    }

    // Save the new user's data
    _users.add({
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'gender': gender,
    });
    _user = email; // Log in automatically after registration
    notifyListeners();
  }

  // Log in a user
  Future<void> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    final user = _users.firstWhere(
          (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) {
      throw Exception("Invalid email or password");
    } else {
      _user = email;
      notifyListeners();
    }
  }

  // Log out the user
  void logout() {
    _user = null;
    notifyListeners();
  }

  // Update user's profile
  void updateUserProfile(String newName, String newPhone, String newGender) {
    final userIndex = _users.indexWhere((user) => user['email'] == _user);
    if (userIndex != -1) {
      // Validate gender (must be either 'Nam' or 'Nữ')
      if (newGender != 'Nam' && newGender != 'Nữ') {
        throw Exception("Gender must be 'Nam' or 'Nữ'");
      }

      _users[userIndex] = {
        'name': newName,
        'email': _users[userIndex]['email']!, // Keep the email
        'password': _users[userIndex]['password']!, // Keep the password
        'phone': newPhone,
        'gender': newGender,
      };
      notifyListeners();
    }
  }

  // Get the current user's information
  Map<String, String>? get currentUser {
    return _users.firstWhere(
          (user) => user['email'] == _user,
      orElse: () => {},
    );
  }
}
