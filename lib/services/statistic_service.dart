import 'dart:convert';
import 'package:cms_chat_app/dto/response_dto.dart';
import 'package:cms_chat_app/services/api_services.dart';

class StatisticService {
  final ApiService _apiService = ApiService();

  Future<ResponseDto> userStats(int status, int page, int size) async {
    final response = await _apiService.get(
      "/v1/statistic/users",
      requiresAuth: true,
    );
    final dto = ResponseDto.fromJson(jsonDecode(response.body));
    return dto;
  }

  Future<ResponseDto> conversationStats(int status, int page, int size) async {
    final response = await _apiService.get(
      "/v1/statistic/conversations",
      requiresAuth: true,
    );
    final dto = ResponseDto.fromJson(jsonDecode(response.body));
    return dto;
  }

  Future<ResponseDto> postStats(int status, int page, int size) async {
    final response = await _apiService.get(
      "/v1/statistic/posts",
      requiresAuth: true,
    );
    final dto = ResponseDto.fromJson(jsonDecode(response.body));
    return dto;
  }
}
