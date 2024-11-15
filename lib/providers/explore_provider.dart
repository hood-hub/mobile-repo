import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user_model.dart';
import 'dio_providers/dio_provider.dart';
part 'explore_provider.g.dart';

@riverpod
Future<List<UserModel>?> getNearByUsers(Ref ref, {int distance = 20}) async {
  String endpoint = '/api/v1/user/get-nearby-users?distance=$distance';

  try {
    final response = await ref.watch(dioServiceProvider).getRequest(endpoint);
    if (response.statusCode == 200 && response.data['success'] == true) {
      List<dynamic> data = response.data['data'];
      return data.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load nearbyusers');
    }
  } catch (e, s) {
    print('get nearbyusers $e $s');
    throw Exception('Error fetching nearbyusers: $e');
  }
}