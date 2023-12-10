
import 'usuario.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('https://randomuser.me/api/?results=5');

      if (response.statusCode == 200) {
        List<User> users = (response.data['results'] as List).map((json) => User.fromJson(json)).toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}