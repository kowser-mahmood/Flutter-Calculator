import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({required this.ontap, required this.icon});
  final Function ontap;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(onPressed: () => ontap(), child: Text(icon)),
    );
  }
}