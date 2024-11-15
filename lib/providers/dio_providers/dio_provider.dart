// lib/src/providers/dio_provider.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/auth_service.dart';
import '../../services/dio_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


// FlutterSecureStorage instance
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Token provider with caching
final tokenProvider = StateNotifierProvider<TokenNotifier, String?>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return TokenNotifier(secureStorage);
});

class TokenNotifier extends StateNotifier<String?> {
  final FlutterSecureStorage _secureStorage;

  TokenNotifier(this._secureStorage) : super(null) {
    _loadToken();
  }

  // Load token from secure storage when provider is first created
  Future<void> _loadToken() async {
    final token = await _secureStorage.read(key: 'auth_token');
    state = token;
  }

  // Save new token and update state
  Future<void> setToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
    state = token;
  }

  // Clear token
  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'auth_token');
    state = null;
  }
}



/// Provider for Dio instance
final dioInstanceProvider = Provider<Dio>((ref) {
  return Dio();
});

/*/// Provider for FlutterSecureStorage
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});*/

/// Provider for DioService
final dioServiceProvider = Provider<DioService>((ref) {
  final dio = ref.read(dioInstanceProvider);
  final secureStorage = ref.read(secureStorageProvider);
  return DioService(dio, secureStorage, ref);
});

/// Provider for GoogleSignIn
final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );
});

/// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  final dioService = ref.read(dioServiceProvider);
  final googleSignIn = ref.read(googleSignInProvider);
  final secureStorage = ref.read(secureStorageProvider);
  return AuthService(dioService, googleSignIn, secureStorage);
});
