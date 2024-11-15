import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/comment_model.dart';
import '../models/postmodel.dart';
import 'dio_providers/dio_provider.dart';
part 'home_provider.g.dart';


@riverpod
class HomeFilter extends _$HomeFilter {
  @override
  String build() => 'get-all';

  updateFilter(String param) {
    state = param;
  }
}



@riverpod
Future<bool> likePost(Ref ref, {required String id}) async {
  try {
    final response = await ref.watch(dioServiceProvider).postRequest('/api/v1/post/like/$id');
    if (response.data['success'] == true) {
      return true;
    } else {
      return false;
    }
  } catch (e,s) {
    return false;
  }
}

@riverpod
Future<bool> unLikePost(Ref ref, {required String id}) async {
  try {
    final response = await ref.watch(dioServiceProvider).postRequest('/api/v1/post/remove-like/$id');
    if (response.data['success'] == true) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

@riverpod
Future<bool> postComment(Ref ref, {required String postId, required String comment}) async {
  try {
    final response = await ref.watch(dioServiceProvider).postRequest(
      '/api/v1/post/comment/$postId',
      data: {'body': comment},
    );
    if (response.data['success'] == true) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

@riverpod
Future<List<CommentModel>> getComments(Ref ref, {required String postId}) async {
  try {
    final response = await ref.watch(dioServiceProvider).getRequest('/api/v1/post/get-comments-by-post/$postId');
    if (response.data['success'] == true) {
      List<dynamic> data = response.data['data'];
      return data.map((comment) => CommentModel.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  } catch (e, s) {
    print('Error fetching comments: $e $s');
    throw Exception('Error fetching comments: $e');
  }
}


@riverpod
Future<List<PostModel>> getPosts(Ref ref, {int page = 1}) async {
  final filter = ref.watch(homeFilterProvider);
  String endpoint;

  switch (filter) {
    case 'for-you':
      endpoint = '/api/v1/post/get-by-user-address';
      break;
    case 'trending':
      endpoint = '/api/v1/post/get-trending';
      break;
    default:
      endpoint = '/api/v1/post/get-all';
  }

  try {
    final response = await ref
        .watch(dioServiceProvider)
        .getRequest('$endpoint?page=$page');
    if (response.statusCode == 200 && response.data['success'] == true) {
      final data = response.data['data']['posts'] as List;
      return data.map((post) => PostModel.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (e, s) {
    print('get posts $e $s');
    throw Exception('Error fetching posts: $e');
  }
}


@riverpod
class HomePostsNotifier extends _$HomePostsNotifier {
  List<PostModel> _posts = [];
  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  @override
  Future<List<PostModel>> build() async {
    // Watch for changes to the filter and reset pagination on changes
    ref.watch(homeFilterProvider);
    return _fetchPosts(reset: true);
  }

  Future<List<PostModel>> _fetchPosts({bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _isLastPage = false;
      _posts = [];
    }

    if (_isLastPage) {
      return _posts;
    }

    final newPosts = await ref.read(getPostsProvider(page: _currentPage).future);
    if (newPosts.isEmpty) {
      _isLastPage = true;
    } else {
      _posts.addAll(newPosts);
      _currentPage++;
    }

    state = AsyncValue.data(_posts);
    return _posts;
  }

  Future<void> loadMore() async {
    if (state.isLoading || _isLastPage) return;
    await _fetchPosts();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _fetchPosts(reset: true);
  }

  Future<void> updatePost(PostModel updatedPost) async {
    final currentState = await future;
    if (currentState case final posts?) {
      state = AsyncValue.data(
        posts.map((post) => post.id == updatedPost.id ? updatedPost : post).toList(),
      );
    }
  }
}
