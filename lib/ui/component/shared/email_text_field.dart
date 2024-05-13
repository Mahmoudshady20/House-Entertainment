import 'package:flutter/material.dart';
import 'package:houseenterainment/ui/component/shared/custom_form_field.dart';
import 'package:houseenterainment/ui/component/utils/validations_regex.dart';


class EmailTextField extends StatelessWidget {
  const EmailTextField({required this.emailController,super.key});
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return CustomFormField(
        label: 'Email Address',
        isLogin: true,
        controller: emailController,
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your Email';
          }
          if (!ValidationRegex.emailRegex(value)) {
            return 'Please enter Valid Email';
          }
          return null;
        });
  }
}
