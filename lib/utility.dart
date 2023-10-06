import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static late final SharedPreferences prefs;

  static int LEVELNO = 0;

  static List imagePaths = [];

  Future initImages() async {
    final manifestContent = await rootBundle.loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    imagePaths = manifestMap.keys
        .where((String key) => key.contains("img/game_img/"))
        .toList();
  }

  static List<String> statusLst = [];

  static String CLEAR = "clear";
  static String PENDING = "pending";
  static String SKIP = "skip";
}
