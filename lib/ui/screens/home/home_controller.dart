import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../services/dio_service.dart';
import 'package:hoodhub/models/models.dart';

class HomeController {
  final DioService _dioService;

  HomeController(this._dioService);

  /// Fetch posts from API
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _dioService.getRequest('/api/v1/post/get-by-user');
      if (response.statusCode == 200 && response.data['success'] == true) {
        List<dynamic> data = response.data['data'];
        return data.map((post) => PostModel.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }
}
