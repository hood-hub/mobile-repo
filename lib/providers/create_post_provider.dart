

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoodhub/services/media_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dio_providers/dio_provider.dart';
part 'create_post_provider.g.dart';

@riverpod
MediaService mediaService(Ref ref) => MediaService();

@riverpod
Future<Object?> createPost(Ref ref, {dynamic? body}) async {
  try {
    final response = await ref.watch(dioServiceProvider).postRequest(
      '/api/v1/post',
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
Future<Object?> createIncident(Ref ref, {dynamic? body}) async {
  try {
    final response = await ref.watch(dioServiceProvider).postRequest(
      '/api/v1/post/create-incident',
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
Future<List<String>?> uploadFiles(Ref ref) async {
  try {
    final mediaService = ref.watch(mediaServiceProvider);

    // Pick multiple media files (images and videos)
    List<File> files = await mediaService.pickMultipleMedia();

    if (files.isEmpty) {
      throw Exception('No files selected');
    }

    // Create a list of MultipartFile for the selected files
    final List<MultipartFile> multipartFiles = [];
    for (var file in files) {
      multipartFiles.add(await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ));
    }

    // Make the POST request to upload multiple files
    final response = await ref.watch(dioServiceProvider).postRequest(
      '/api/v1/upload/multiple-files',
      files: multipartFiles,
    );

    // Check the response and return the list of uploaded file URLs if successful
    if (response.statusCode == 200 && response.data['success'] == true) {
      return List<String>.from(response.data['data']);
    } else {
      throw Exception('File upload failed: ${response.data['message']}');
    }
  } catch (e) {
    throw Exception('Error uploading files: $e');
  }
}