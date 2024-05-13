import 'package:flutter/material.dart';
import 'package:houseenterainment/ui/component/shared/custom_form_field.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({required this.passwordController,super.key});
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    bool hidePassword = true;
    return StatefulBuilder(
      builder: (context, setState) => CustomFormField(
        isLogin: true,
        label: 'password',
        controller: passwordController,
        textInputType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your Password';
          }
          return null;
        },
        isPassword: hidePassword,
        suffix: IconButton(
          onPressed: () {
            if (hidePassword == false) {
              hidePassword = true;
            } else {
              hidePassword = false;
            }
            setState(() {});
          },
          icon: hidePassword
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


