

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/message_model.dart';
import '../../../providers/dio_providers/dio_provider.dart';
part 'chat_provider.g.dart';


@riverpod
class ChatFilter extends _$ChatFilter {
  @override
  String build() => 'groups';

  void updateFilter(String filter) {
    state = filter;
  }
}

@riverpod
class GroupListNotifier extends _$GroupListNotifier {
  List<Map<String, dynamic>> _groups = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLastPage = false;

  bool get isLastPage => _isLastPage;

  @override
  Future<List<Map<String, dynamic>>> build() async {
    return _fetchGroups(reset: true);
  }

  Future<List<Map<String, dynamic>>> _fetchGroups({bool reset = false}) async {
    if (reset) {
      _groups = [];
      _currentPage = 1;
      _isLastPage = false;
    }

    if (_isLastPage) return _groups;

    try {
      final response = await ref
          .read(dioServiceProvider)
          .getRequest('/api/v1/group?page=$_currentPage');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        _totalPages = data['totalPages'];
        final newGroups = (data['groups'] as List)
            .map((group) => group as Map<String, dynamic>)
            .toList();

        if (_currentPage >= _totalPages) {
          _isLastPage = true;
        } else {
          _currentPage++;
        }

        _groups.addAll(newGroups);
        state = AsyncValue.data(_groups);
        return _groups;
      } else {
        throw Exception('Failed to load groups');
      }
    } catch (e) {
      throw Exception('Error fetching groups: $e');
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || _isLastPage) return;
    await _fetchGroups();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _fetchGroups(reset: true);
  }
}


@riverpod
Future<List<Map<String, dynamic>>> getGroups(Ref ref) async {
  try {
    final response = await ref.watch(dioServiceProvider).getRequest('/api/v1/group/get-my-groups');
    if (response.statusCode == 200 && response.data['success'] == true) {
      final groups = response.data['data']['groups'] as List;
      return groups.map((group) => group as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  } catch (e, s) {
    print('get groups $e $s');
    throw Exception('Error fetching groups: $e');
  }
}

@riverpod
Future<List<Map<String, dynamic>>> getDMs(Ref ref) async {
  try {
    final response = await ref.watch(dioServiceProvider).getRequest('/api/v1/message/get-my-direct-messages');
    if (response.statusCode == 200 && response.data['success'] == true) {
      final groups = response.data['data']['dms'] as List;
      return groups.map((group) => group as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  } catch (e, s) {
    print('get groups $e $s');
    throw Exception('Error fetching groups: $e');
  }
}


@riverpod
class GetChatList extends _$GetChatList {
  List<Map<String, dynamic>> _chatList = [];
  int _currentPage = 1;
  bool _isLastPage = false;

  bool get isLastPage => _isLastPage;

  @override
  Future<List<Map<String, dynamic>>> build() async {
    ref.watch(chatFilterProvider); // Listen to filter changes
    return _fetchChats(reset: true);
  }

  Future<List<Map<String, dynamic>>> _fetchChats({bool reset = false}) async {
    if (reset) {
      _chatList = [];
      _currentPage = 1;
      _isLastPage = false;
    }

    if (_isLastPage) return _chatList;

    final filter = ref.read(chatFilterProvider);
    final endpoint =
    filter == 'groups' ? '/api/v1/group/get-my-groups' : '/api/v1/message/get-my-direct-messages';
    final response = await ref
        .read(dioServiceProvider)
        .getRequest('$endpoint?page=$_currentPage');

    if (response.statusCode == 200 && response.data['success'] == true) {
      final data = response.data['data'];
      final items = (data['groups'] ?? data['dms']) as List;
      if (items.isEmpty ) {
        _isLastPage = true;
      } else {
        final uniqueItems = items
            .map((e) => e as Map<String, dynamic>)
            .where((newItem) => !_chatList.any((existingItem) =>
        existingItem['_id'] == newItem['_id'])) // Match by unique ID
            .toList();

        _chatList.addAll(uniqueItems);
        if (items.length < 9) {
          _isLastPage = true;
        }
        _currentPage++;
      }
      state = AsyncValue.data(_chatList);
    } else {
      throw Exception('Failed to load chats');
    }

    return _chatList;
  }

  Future<void> loadMore() async {
    if (state.isLoading || _isLastPage) return;
    await _fetchChats();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _fetchChats(reset: true);
  }

}


@riverpod
Future<List<Map<String, dynamic>>> getMessages(Ref ref, {required String chatId, required bool isGroup}) async {
  final endpoint = isGroup ? '/api/v1/message/get-by-group/$chatId' : '/api/v1/message/get-by-dm/$chatId';
  try {
    final response = await ref.watch(dioServiceProvider).getRequest(endpoint);
    if (response.statusCode == 200 && response.data['success'] == true) {
      final messages = response.data['data']['messages'] as List;
      return messages.map((message) => message as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  } catch (e, s) {
    print('get messages $e $s');
    throw Exception('Error fetching messages: $e');
  }
}

@riverpod
Future<List<Map<String, dynamic>>> getMessagesByGroup(Ref ref, {required String groupId}) async {
  return getMessages(ref, chatId: groupId, isGroup: true);
}

@riverpod
Future<List<Map<String, dynamic>>> getMessagesByDM(Ref ref, {required String dmId}) async {
  return getMessages(ref, chatId: dmId, isGroup: false);
}


@riverpod
class MessageNotifier extends _$MessageNotifier {
  Timer? _refreshTimer;

  @override
  FutureOr<List<Message>> build(String chatId, bool isGroup) async {
    // Initial load
    await _loadMessages();

    // Set up periodic refresh
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _loadMessages();
    });

    // Cancel timer when disposing
    ref.onDispose(() {
      _refreshTimer?.cancel();
    });

    return [];
  }

  Future<void> _loadMessages() async {
    final dio = ref.read(dioServiceProvider);
    try {
      final endpoint = isGroup
          ? '/api/v1/message/get-by-group/$chatId'
          : '/api/v1/message/get-by-direct-message/$chatId';

      final response = await dio.getRequest(endpoint);
      if (response.statusCode == 200) {
        final messagesResponse = MessagesResponse.fromJson(response.data['data']);
        state = AsyncData(messagesResponse.messages);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> sendMessage(String content, {List<String> media = const []}) async {
    final dio = ref.read(dioServiceProvider);
    try {
      final message = {
        'content': content,
        'media': media,
        if (isGroup) 'group': chatId else 'directMessage': chatId,
      };

      final response = await dio.postRequest(
        '/api/v1/message',
        data: message,
      );

      if (response.statusCode == 200) {
        // Reload messages after successful send
        await _loadMessages();
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to send message: $e');
    }
  }
}

/*
@riverpod
class MessageNotifier extends _$MessageNotifier {
  Timer? _refreshTimer;

  @override
  FutureOr<List<Message>> build(String chatId, bool isGroup) async {
    // Initial load
    await _loadMessages();

    // Start periodic refresh after initial load is complete
    _startPeriodicRefresh();

    // Cancel timer when disposing
    ref.onDispose(() {
      _refreshTimer?.cancel();
    });

    return state.value ?? [];
  }

  void _startPeriodicRefresh() {
    _refreshTimer?.cancel(); // Cancel any existing timer
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _loadMessages();
    });
  }

  Future<void> _loadMessages() async {
    if (state.isLoading) return; // Prevent multiple simultaneous loads

    final dio = ref.read(dioServiceProvider);
    try {
      state = const AsyncLoading();

      final endpoint = isGroup
          ? '/api/v1/message/get-by-group/$chatId'
          : '/api/v1/message/get-by-dm/$chatId';

      final response = await dio.getRequest(endpoint);
      if (response.statusCode == 200) {
        final messagesResponse = MessagesResponse.fromJson(response.data['data']);
        state = AsyncData(messagesResponse.messages);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> sendMessage(String content, {List<String> media = const []}) async {
    final dio = ref.read(dioServiceProvider);
    try {
      final message = {
        'content': content,
        'media': media,
        if (isGroup) 'group': chatId else 'directMessage': chatId,
      };

      final response = await dio.postRequest(
        '/api/v1/message',
        data: message,
      );

      if (response.statusCode == 200) {
        // Reload messages after successful send
        await _loadMessages();
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}*/
