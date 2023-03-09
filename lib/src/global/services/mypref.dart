import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:triviago/src/global/model/user.dart';
import 'package:triviago/src/global/services/http_service.dart';
import 'package:triviago/src/global/ui/ui_barrel.dart';
import 'package:triviago/src/plugin/jwt.dart';

class MyPrefs {
  static const String mpLoggedInEmail = "mpLoggedInEmail";
  static const String mpLoggedInURLPhoto = "mpLoggedInURLPhoto";
  static const String mpLoggedInPhone = "mpLoggedInPhone";
  static const String mpIsLoggedIn = "mpIsLoggedIn";
  static const String mpUserID = "mpUserID";
  static const String mpUserJWT = "mpUserJWT";
  static const String mpLoginExpiry = "mpLoginExpiry";
  static const String mpLatLng = "mpLatLng";
  static const String hasOpenedOnboarding = "hasOpenedOnboarding";
  static const String mpUserRole = "mpUserRole";
  static const String mpUserName = "mpUserName";

  static final _prefs = GetStorage();

  static Future<void> writeData(String key, dynamic value) async {
    await _prefs.write(key, value);
  }

  static dynamic readData(String key) {
    return _prefs.read(key);
  }

  // static void listenToStorageChanges(String k, void Function(dynamic) v) {
  //   _prefs.listenKey(k, (j) {
  //     final jwt = readData(mpUserJWT);
  //     final id = readData(mpUserID);
  //     if (jwt == "" || id == "") return;
  //     v(j);
  //   });
  // }

  static Future<bool> login(User user) async {
    await rawLogin(user);
    // await saveJWT(jwt);
    // await _prefs.write(mpLogin3rdParty, is3rdParty);

    // await HttpService.toggleDeviceToken();
    return true;
  }

  static Future<void> saveJWT(String jwt) async {
    final msg = Jwt.parseJwt(jwt);
    await _prefs.write(mpLoginExpiry, msg["exp"]);
    await _prefs.write(mpUserJWT, jwt);
  }

  static bool hasOpened() {
    bool a = _prefs.read(hasOpenedOnboarding) ?? false;
    if (a == false) {
      _prefs.write(hasOpenedOnboarding, true);
    }
    return a;
  }

  static Future<bool> isLoggedIn() async {
    return _prefs.read(mpIsLoggedIn) ?? false;
  }

  static User localUser() {
    return User(
      username: _prefs.read(mpUserName) ?? "",
      id: _prefs.read(mpUserID) ?? "",
      phone: _prefs.read(mpLoggedInPhone) ?? "",
      image: _prefs.read(mpLoggedInURLPhoto) ?? "",
    );
  }

  static rawLogin(User user) async {
    await _prefs.write(mpUserName, user.username);
    await _prefs.write(mpLoggedInURLPhoto, user.image);
    await _prefs.write(mpUserID, user.id);
    await _prefs.write(mpLoggedInPhone, user.phone);
    await _prefs.write(mpIsLoggedIn, true);
  }

  static listenToPrefChanges(String key, ValueSetter callback) {
    _prefs.listenKey(key, (value) {
      callback(value);
    });
  }

  static Future<void> logout() async {
    await eraseAllExcept("");
  }

  static eraseAllExcept(String key) async {
    final allKeys = _prefs.getKeys<Iterable<String>>().toList();
    for (var element in allKeys) {
      if (element == key) continue;
      _prefs.remove(element);
    }
  }
}
