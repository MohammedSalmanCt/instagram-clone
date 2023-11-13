import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Shared2.dart';

class Shared1 extends StatefulWidget {
  const Shared1({super.key});

  @override
  State<Shared1> createState() => _Shared1State();
}

class _Shared1State extends State<Shared1> {
  TextEditingController aa = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: aa,
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                if (aa.text.isNotEmpty) {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('name', aa.text);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Shared2();
                    },
                  ));
                }
                ;
              },
              child: Text("Button"))
        ],
      ),
    );
  }
}
