import 'package:flutter/material.dart';

class RespnsiveText extends StatelessWidget {
  const RespnsiveText({
    @required this.color,
    @required this.text,
    @required this.percentage,
  });

  final String text;
  final Color color;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: MediaQuery.of(context).size.width * percentage,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
