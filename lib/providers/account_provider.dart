

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dio_providers/dio_provider.dart';
part 'account_provider.g.dart';


@riverpod
Future<Object?> updateProfile(Ref ref, {dynamic? body}) async {
  print('proff $body');
  try {
    final response = await ref.watch(dioServiceProvider).putRequest(
      '/api/v1/user/update-profile',
      data: body,
    );
    print(response);
    if (response.data['success'] == true) {
      return response;
    } else {
      return null;
    }
  } catch (e, s) {
    print('$e $s');
    return null;
  }
}


@riverpod
Future<Object?> updatePassword(Ref ref, {dynamic? body}) async {
  try {
    final response = await ref.watch(dioServiceProvider).putRequest(
      '/api/v1/user/change-password',
      data: body,
    );
    print(response.data);
    if (response.data['success'] == true) {
      return response;
    } else {
      return null;
    }
  } catch (e, s) {
    print('$e $s');
    return null;
  }
}

@riverpod
Future<Object?> updateEmergencyContact(Ref ref, {dynamic? body}) async {
  try {
    final response = await ref.watch(dioServiceProvider).putRequest(
      '/api/v1/user/update-emergency-contact',
      data: body,
    );
    print(response.data);
    if (response.data['success'] == true) {
      return response;
    } else {
      return null;
    }
  } catch (e, s) {
    print('$e $s');
    return null;
  }
}

@riverpod
Future<Object?> logout(Ref ref) async {
  try {
    final response = await ref.watch(dioServiceProvider).getRequest(
      '/api/v1/user/logout',
    );
    print(response.data);
    if (response.data['success'] == true) {
      return response;
    } else {
      return null;
    }
  } catch (e, s) {
    print('$e $s');
    return null;
  }
}