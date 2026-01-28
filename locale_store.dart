
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LocaleStore extends ChangeNotifier {
  static const _key='app_locale';
  Locale? _locale; Locale? get locale=>_locale;
  Future<void> load() async { final sp=await SharedPreferences.getInstance(); final code=sp.getString(_key); if(code!=null&&code.isNotEmpty){ _locale=Locale(code);} notifyListeners(); }
  Future<void> setLocale(Locale l) async { _locale=l; final sp=await SharedPreferences.getInstance(); await sp.setString(_key,l.languageCode); notifyListeners(); }
}
