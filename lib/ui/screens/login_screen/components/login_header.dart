import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({required this.word, super.key});
  final String word;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/img.png'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          word,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
        ),
      ],
    );
  }
}
