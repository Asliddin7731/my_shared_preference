import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preference/model/user_model.dart';
import 'package:shared_preference/service/logger_service.dart';

class SecureService {
  static storeApiKey (String api_key) async{
    const storage = FlutterSecureStorage();
    await storage.write(key: 'api_key', value: api_key);
  }

  static Future<String?> loadApiKey () async{
    const storage = FlutterSecureStorage();
    String? api_key = await storage.read(key: 'api_key');
    return api_key;
  }

  static Future<void> removeApiKey () async{
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'api_key');
  }

  static storeApiKeyUser (User user) async{
    const storage = FlutterSecureStorage();
    String userString = jsonEncode(user.toJson());
    await storage.write(key: 'api_key', value: userString);
    LoggerService.i(userString.toString());
  }

  static Future<User?> loadApiKeyUser () async{
    const storage = FlutterSecureStorage();
    String? userString = await storage.read(key: 'api_key') ?? '';
    if (userString.isEmpty) return null;

    Map<String, dynamic> map = jsonDecode(userString);
    return User.fromJson(map);
  }

  static Future<void> removeApiKeyUser () async{
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'api_key');
  }

}