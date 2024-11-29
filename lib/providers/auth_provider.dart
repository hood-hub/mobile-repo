import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoodhub/models/user_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dio_providers/dio_provider.dart';

part 'auth_provider.g.dart';

/// Decode JWT token to extract user details
String? getUserId(String token) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  return decodedToken['_id'];
}

@riverpod
Future<UserModel?> getUser(Ref ref) async {

  print('yaa');
  try {
/*    final userEnc = await ref.read(secureStorageProvider).read(key: 'auth_user');
    if (userEnc != null) {
      final user = UserModel.fromJson(jsonDecode(userEnc));
      return user;
    }*/

    var token = await ref.read(secureStorageProvider).read(key: 'auth_token');
    var id = getUserId(token!);
    final response = await ref.watch(dioServiceProvider).getRequest('/api/v1/user/get-one-user/$id');
    if (response.data['success'] == true) {
      final data = response.data['data'];
      final user = UserModel.fromJson(data);
      print('getUser ${user.toJson()}');

      // Write the authenticated user to secure storage if the user is not null
      final userJson = jsonEncode(user.toJson());
      await ref.read(secureStorageProvider).write(key: 'auth_user', value: userJson);

      return user;
    }
    return null;
  } catch (e,s) {
    print('$e,$s');
    return null;
  }
}
/*
@riverpod
Future<UserModel?> getUser2() async {

  print('yaa');
  try {
*//*    final userEnc = await ref.read(secureStorageProvider).read(key: 'auth_user');
    if (userEnc != null) {
      final user = UserModel.fromJson(jsonDecode(userEnc));
      return user;
    }*//*

    var token = await ref.read(secureStorageProvider).read(key: 'auth_token');
    var id = getUserId(token!);
    final response = await ref.watch(dioServiceProvider).getRequest('/api/v1/user/get-one-user/$id');
    if (response.data['success'] == true) {
      final data = response.data['data'];
      final user = UserModel.fromJson(data);

      // Write the authenticated user to secure storage if the user is not null
      final userJson = jsonEncode(user.toJson());
      await ref.read(secureStorageProvider).write(key: 'auth_user', value: userJson);

      return user;
    }
    return null;
  } catch (e,s) {
    print('$e,$s');
    return null;
  }
}*/

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<UserModel?> build() async {
    try {

      var token = await ref.read(secureStorageProvider).read(key: 'auth_token');
      var id = getUserId(token!);
      final response = await ref.watch(dioServiceProvider).getRequest('/api/v1/user/get-one-user/$id');
      if (response.data['success'] == true) {
        final data = response.data['data'];
        final user = UserModel.fromJson(data);
        print('getUser ${user.toJson()}');

        // Write the authenticated user to secure storage if the user is not null
        final userJson = jsonEncode(user.toJson());
        await ref.read(secureStorageProvider).write(key: 'auth_user', value: userJson);

        return user;
      }
      return null;
    } catch (e,s) {
      print('$e,$s');
      return null;
    }
  }

  // Load user data from API or secure storage
  Future<UserModel?> loadUser() async {
    try {
      final userEnc = await ref.read(secureStorageProvider).read(key: 'auth_user');
      if (userEnc != null) {
        final user = UserModel.fromJson(jsonDecode(userEnc));
        state = AsyncValue.data(user);
      }

      final user = await ref.read(getUserProvider.future);
      state = AsyncValue.data(user);
      return user;
    } catch (e,s) {
      state = AsyncValue.error(e,s);
      return null;
    }
  }

  refreshUser() async {
    //ref.invalidate(getUserProvider);
     ref.invalidateSelf();
  }


  // Update user data
  Future<bool> updateUser(UserModel user) async {
    try {
      final response = await ref.read(dioServiceProvider).postRequest(
        '/api/v1/user/update',
        data: user.toJson(),
      );

      if (response.data['success'] == true) {
        // Update the state with the new user data
        final updatedUser = UserModel.fromJson(response.data['data']);
        state = AsyncValue.data(updatedUser);

        // Update the user in secure storage as well
        final userJson = jsonEncode(updatedUser.toJson());
        await ref.read(secureStorageProvider).write(key: 'auth_user', value: userJson);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Clear user data from state and secure storage
  Future<void> clearUser() async {
    try {
      await ref.read(secureStorageProvider).delete(key: 'auth_token');
      await ref.read(secureStorageProvider).delete(key: 'auth_user');
      state = const AsyncValue.data(null);
    } catch (e,s) {
      state = AsyncValue.error(e,s);
    }
  }
}

