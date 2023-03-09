import 'package:triviago/src/global/model/user.dart';
import 'package:triviago/src/global/services/mypref.dart';

class HttpService {
  static Future<void> login(String username, String phone, String image) async {
    await MyPrefs.login(User(username: username, phone: phone, image: image));
  }

  static Future<void> logout() async {
    await MyPrefs.logout();
  }
}
