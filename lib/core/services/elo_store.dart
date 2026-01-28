
import 'package:shared_preferences/shared_preferences.dart';
class EloStore {
  static int elo=1600;
  static Future<void> init() async { final sp=await SharedPreferences.getInstance(); elo=sp.getInt('elo')??1600; }
  static Future<int> update(int d) async { final sp=await SharedPreferences.getInstance(); elo+=d; if(elo<800) elo=800; if(elo>2800) elo=2800; await sp.setInt('elo', elo); return elo; }
  static Future<void> reset() async { final sp=await SharedPreferences.getInstance(); elo=1600; await sp.setInt('elo', elo); }
}
