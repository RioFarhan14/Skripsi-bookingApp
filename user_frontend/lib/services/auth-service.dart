import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_frontend/utils/constants.dart';

class AuthService {
  static const String baseUrl = BASE_URL;

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/login'),
      body: json.encode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['errors'] ?? 'Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(String username, String password,
      String confirmPassword, String name, String userPhone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users'),
      body: json.encode({
        'username': username,
        'password': password,
        'confirm_password': confirmPassword,
        'name': name,
        'user_phone': userPhone,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['errors'] ?? 'Registration failed');
    }
  }

  Future<Map<String, dynamic>> updateUserData(
    String token,
    Map<String, dynamic> updatedData, {
    String? username,
    String? password,
    String? confirmPassword,
    String? name,
    String? userPhone,
  }) async {
    final Map<String, dynamic> body = {};

    // Hanya tambahkan data yang tidak null ke dalam body
    if (username != null) body['username'] = username;
    if (password != null) body['password'] = password;
    if (confirmPassword != null) body['confirm_password'] = confirmPassword;
    if (name != null) body['name'] = name;
    if (userPhone != null) body['user_phone'] = userPhone;

    final response = await http.patch(
      Uri.parse('$baseUrl/api/users'),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token, // Mengirim token untuk autentikasi
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['errors'] ?? 'Update failed');
    }
  }

  Future<void> logout(String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/users/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['errors'] ?? 'Registration failed');
    }
  }

  Future<Map<String, dynamic>> getUserData(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/users/current'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['errors'] ?? 'Registration failed');
    }
  }
}
