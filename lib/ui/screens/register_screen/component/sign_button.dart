import 'package:flutter/material.dart';


class SignButton extends StatelessWidget {

  final void Function()? onPressed;
  const SignButton({required this.formKey,required this.onPressed,super.key});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFF0B6EFE),
          borderRadius: BorderRadius.circular(12)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: const Text(
          'Sign Up',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
    );
  }
}
