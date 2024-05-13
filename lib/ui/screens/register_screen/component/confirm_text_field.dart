import 'package:flutter/material.dart';

import '../../../component/shared/custom_form_field.dart';

class ConfirmTextField extends StatelessWidget {
  const ConfirmTextField({required this.confirmPasswordController,required this.passwordController,super.key});
  final TextEditingController confirmPasswordController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    bool hideConfirmPassword = true;
    return StatefulBuilder( builder: (context, setState) => CustomFormField(
        label: 'confirm password',
        controller: confirmPasswordController,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'please enter password-confirmation';
          }
          if (passwordController.text != value) {
            return "password doesn't match";
          }
          return null;
        },
        isPassword: hideConfirmPassword,
        suffix: IconButton(
          onPressed: () {
            if (hideConfirmPassword == false) {
              hideConfirmPassword = true;
            } else {
              hideConfirmPassword = false;
            }
            setState(() {});
          },
          icon: hideConfirmPassword
              ? const Icon(
            Icons.visibility,
            color: Colors.grey,
          )
              : const Icon(
            Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
