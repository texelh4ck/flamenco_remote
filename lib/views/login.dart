import 'package:flamenco_remote/providers/preferences.dart';
import 'package:flamenco_remote/widgets/bg_gradient.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  String server = "";
  Preferences pref = Preferences();

  List<String> last = ["192.168.145.147:8080"];

  @override
  Widget build(BuildContext context) {
    last = pref.lastServers();
    if (last.length > 3) {
      last = last.getRange(0, 3).toList();
    }
    return Scaffold(
      body: BgGradient(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _brand(),
                const SizedBox(height: 20),
                _inputServer(context),
                const SizedBox(height: 20),
                _lastConections(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _verifyStatus(String server) async {
    var url = Uri.http(server, "/api/v3/status");
    try {
      var res = await http.get(url);
    } catch (e) {
      return false;
    }

    return true;
  }

  Widget _brand() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/brand.svg", width: 70),
        const SizedBox(width: 15),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Flamenco",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            ),
            Text("Remote")
          ],
        )
      ],
    );
  }

  Widget _lastConections(BuildContext context) {
    return Column(
      children: last.map((e) {
        return GestureDetector(
          onTap: () => _openServer(context, e),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                FutureBuilder(
                    future: _verifyStatus(e),
                    initialData: false,
                    builder: (context, snapshot) {
                      return Icon(
                        Icons.circle,
                        size: 13,
                        color: snapshot.data!
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      );
                    }),
                const SizedBox(width: 10),
                Text(e, style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _inputServer(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: SizedBox(
            child: TextField(
              onChanged: (String value) {
                server = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Server",
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _openServer(context, server);
          },
          icon: const Icon(Icons.navigate_next),
        )
      ],
    );
  }

  _openServer(BuildContext context, String server) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    var ok = await _verifyStatus(server);
    Navigator.pop(context);
    if (ok) {
      last.add(server);
      Navigator.pushNamed(context, "/home", arguments: server);
      pref.addLastServers = server;
    }
  }
}
