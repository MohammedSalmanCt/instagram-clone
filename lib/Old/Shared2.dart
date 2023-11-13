import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sintask/Old/sample.dart';
import '';

class Shared2 extends StatefulWidget {
  const Shared2({super.key});

  @override
  State<Shared2> createState() => _Shared2State();
}

class _Shared2State extends State<Shared2> {
  String name = "";

  getLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(name),
          ElevatedButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Shared1();
                },
              ));
            },
            child: Text("back"),
          )
        ],
      ),
    );
  }
}
