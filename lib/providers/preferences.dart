import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _pref;

  static Future init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  List<String> lastServers() => _pref!.getStringList("last-servers") ?? [];

  set addLastServers(String server) {
    var servers = lastServers();
    if (servers.contains(server)) return;
    servers.insert(0, server);
    _pref!.setStringList("last-servers", servers);

  }

}
