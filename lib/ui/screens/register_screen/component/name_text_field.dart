import 'package:flutter/material.dart';

import '../../../component/shared/custom_form_field.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({required this.nameController,super.key});
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      label: 'Full Name',
      controller: nameController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your Name';
        }
        return null;
      },
    );
  }
}
