// lib/src/services/auth_service.dart

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dio_service.dart';

class AuthService {
  final DioService _dioService;
  final GoogleSignIn _googleSignIn;
  final FlutterSecureStorage _secureStorage;

  AuthService(this._dioService, this._googleSignIn, this._secureStorage);

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    try {
      Response response = await _dioService.postRequest(
        '/api/v1/user/login',
        data: {'emailOrUsername': email, 'password': password},
      );

      if (response.statusCode == 200 && response.data['success'] == 'success') {
        String token = response.data['data'];
        await _secureStorage.delete(key: 'auth_token');
        await _saveToken(token);
        return true;
      }
      return false;
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }

  /// Save token in secure storage
  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
    _decodeToken(token);
  }

  /// Decode JWT token to extract user details
  void _decodeToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken['_id'];
    print('User ID: $userId');
    // You can save additional user details if needed
  }

  /// Check if the user is authenticated
  Future<bool> checkAuthStatus() async {
    try {
      String? token = await _secureStorage.read(key: 'auth_token');
      if (token != null && !JwtDecoder.isExpired(token)) {
        return true;
      }
      return false;
    } catch (e) {
      print('Auth Status Check Error: $e');
      return false;
    }
  }
  /// Signup with first name, last name, email, and password
  Future<bool> signup(String firstName, String lastName, String email, String password) async {
    try {
      Response response = await _dioService.postRequest(
        '/api/v1/user',
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        },
      );

      // Check if the response is successful
      if (response.statusCode == 201 && response.data['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print('Signup Error: $e');
      return false;
    }
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      if (idToken == null || accessToken == null) {
        return false;
      }

      // Send tokens to backend for verification and to obtain app-specific auth token
      Response response = await _dioService.postRequest(
        '/auth/google',
        data: {'id_token': idToken, 'access_token': accessToken},
      );

      if (response.statusCode == 200) {
        // Token is already handled by DioService interceptor
        return true;
      }
      return false;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return false;
    }
  }

  /// Verify OTP for 2FA
  Future<bool> verifyOTP({required String email, required int token}) async {
    try {
      Response response = await _dioService.postRequest(
        '/api/v1/user/verify',
        data: {'email': email, 'token': token},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('OTP Verification Error: $e');
      return false;
    }
  }

  /// Forgot Password
  Future<bool> forgotPassword(String emailOrUsername) async {
    try {
      Response response = await _dioService.postRequest(
        '/api/v1/user/forgot-password',
        data: {'emailOrUsername': emailOrUsername},
      );

      return response.statusCode == 200 && response.data['success'] == true;
    } catch (e) {
      print('Forgot Password Error: $e');
      return false;
    }
  }

  /// Reset Password
  Future<bool> resetPassword({required String email, required int token, required String newPassword}) async {
    try {
      Response response = await _dioService.postRequest(
        '/api/v1/user/reset-password',
        data: {
          'emailOrUsername': email,
          'token': token,
          'newPassword': newPassword,
        },
      );

      return response.statusCode == 200 && response.data['success'] == true;
    } catch (e) {
      print('Reset Password Error: $e');
      return false;
    }
  }

  Future<bool> onboardUser({
    required String userId,
    required String username,
    required String stringAddress,
    required Map<String, dynamic> geoAddress,
  }) async {
    try {
      final response = await _dioService.putRequest(
        '/api/v1/user/onboard/$userId',
        data: {
          'username': username,
          'stringAddress': stringAddress,
          'geoAddress': geoAddress,
        },
      );

      return response.data['success'] == true;
    } catch (e) {
      print('Onboard User Error: $e');
      return false;
    }
  }


  /// Logout the user
  Future<void> logout() async {
    // Implement logout logic if needed
    // For example, revoke tokens or notify backend
  }
}
