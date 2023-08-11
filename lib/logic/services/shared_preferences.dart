import 'package:nb_utils/nb_utils.dart';

class Preferences{
  static Future<void> saveUserpreferences(String email, String password) async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("email", email);
    await instance.setString("password", password);

  }
  static Future<Map<String, dynamic>> fetchUserDetail()async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    return {
      "email": email,
      "password": password
    };
  }
  static Future<void> clear()async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }
}