import 'package:shared_preferences/shared_preferences.dart';



class TokenManager {
  late SharedPreferences _sharedPreferences;
  final String jwtTokenKey = 'jwtTokenKey';
  final String userEmailKey = 'userEmailKey';

  TokenManager() {
    _initialize();
  }

  Future<void> _initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<String> getToken() async {
    await _initialize(); // Ensure initialization
    return _sharedPreferences.getString(jwtTokenKey) ?? '';
  }

  Future<String> getEmail() async {
    await _initialize(); // Ensure initialization
    return _sharedPreferences.getString(userEmailKey) ?? '';
  }

  Future<bool> setToken(String token) async {
    await _initialize(); // Ensure initialization
    return await _sharedPreferences.setString(jwtTokenKey, token);
  }

  Future<bool> setEmail(String email) async {
    await _initialize(); // Ensure initialization
    return await _sharedPreferences.setString(userEmailKey, email);
  }

  Future<bool> clearToken() async {
    await _initialize(); // Ensure initialization
    await _sharedPreferences.remove(userEmailKey); // Remove email too
    return await _sharedPreferences.remove(jwtTokenKey);
  }
}

