import 'dart:convert';
import 'package:cms_chat_app/services/api_services.dart';
import 'package:cms_chat_app/dto/response_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final ApiService _apiService = ApiService();

  Future<bool> login(String username, String password) async {
    final response = await _apiService.post(
      "/v1/user/login-admin",
      {'username': username, 'password': password},
      requiresAuth: false,
    );
    final dto = ResponseDto.fromJson(jsonDecode(response.body));
    if (dto.result) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', dto.data['accessToken']);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }

  Future<bool> verifyToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token != null) {
      final response = await _apiService.post(
        '/v1/user/verify-token',
        {'accessToken': token},
        requiresAuth: false,
      );
      if (response.statusCode == 200) {
        return true;
      }
    }
    await prefs.remove('accessToken');
    return false;
  }
}
