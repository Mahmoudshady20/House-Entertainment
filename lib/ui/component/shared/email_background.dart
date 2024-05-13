import 'package:flutter/material.dart';

class AllBackground extends StatelessWidget {
  final Widget child;
  final double? padding;
  const AllBackground({required this.child,super.key,this.padding = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding!),
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/images/splash.png'),
    fit: BoxFit.cover)),
    child: child);
  }
}
