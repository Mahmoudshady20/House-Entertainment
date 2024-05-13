import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({required this.word,required this.routeName,super.key});
  final String word;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
                colors: [
                  // B675FD
                  Color(0xFF0B6EFE),
                  Color(0xFF6196E3),
                  Color(0xFFC4C4C4),
                ],
              ),
            ),
            height: 4,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, routeName);
          },
          child: Text(
            word,
            style: const TextStyle(
              color: Color(0xFF555252),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                colors: [
                  // B675FD
                  Color(0xFF0B6EFE),
                  Color(0xFF6196E3),
                  Color(0xFFC4C4C4),
                ],
              ),
            ),
            height: 4,
          ),
        ),
      ],
    );
  }
}
