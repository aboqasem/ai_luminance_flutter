import 'dart:convert';

import 'package:ai_luminance_flutter/widgets/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int r = 0, g = 0, b = 0;
  String title;
  bool isLight = true;
  Decoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: kColors,
    ),
  );

  @override
  void initState() {
    super.initState();
    // call the server once created so it trains the neural network.
    http.get(kServerUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(r, g, b, 1),
      body: Container(
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: RawMaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () async {
                  try {
                    final String body = (await http.get(kServerUrl)).body;
                    final Map<String, dynamic> json = jsonDecode(body);

                    setState(() {
                      decoration = null;
                      title = json['likely'];
                      r = json['r'];
                      g = json['g'];
                      b = json['b'];
                      isLight = title == 'Light';
                    });
                  } catch (e) {
                    setState(() {
                      decoration = null;
                      title = 'Server Down 🛠';
                      r = 176;
                      g = 0;
                      b = 32;
                      isLight = false;
                    });
                    print('Failed to fetch colors.');
                  }
                },
                child: RespnsiveText(
                  text: title ?? 'Start',
                  color: isLight ? Color(0xff121212) : Colors.white,
                  percentage: 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
