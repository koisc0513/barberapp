import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  List<Map<String, String>> _users = []; // Danh sách người dùng đã đăng ký
  String? _user; // Trạng thái người dùng đăng nhập

  String? get user => _user;
  String? get userName {
    final user = _users.firstWhere(
          (user) => user['email'] == _user,
      orElse: () => {},
    );
    return user.isEmpty ? null : user['name'];
  }

  bool get isLoggedIn => _user != null;

  Future<void> register(String name, String email, String password) async {
    // Giả lập quá trình đăng ký
    await Future.delayed(Duration(seconds: 2));

    // Kiểm tra xem email đã được sử dụng chưa
    if (_users.any((user) => user['email'] == email)) {
      throw Exception("Email already exists");
    }

    // Lưu thông tin người dùng mới vào danh sách
    _users.add({'name': name, 'email': email, 'password': password});
    _user = email; // Đăng nhập ngay sau khi đăng ký
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // Giả lập quá trình đăng nhập
    await Future.delayed(Duration(seconds: 2));

    // Kiểm tra thông tin đăng nhập
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
  void logout() {
    _user = null;
    notifyListeners();
  }
}
