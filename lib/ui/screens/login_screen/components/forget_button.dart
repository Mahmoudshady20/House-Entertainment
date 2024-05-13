import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../component/utils/dialog_utils.dart';

class ForgetButton extends StatelessWidget {
  final FirebaseAuth authServices;
  final String emailAddress;
  const ForgetButton({required this.emailAddress,required this.authServices,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        InkWell(
          onTap: (){
            DialogUtils.showInfo(context, 'Do you want to reset your password?',postActionName: 'Yes',posAction: (){
              authServices.sendPasswordResetEmail(email: emailAddress);
              DialogUtils.showInfo(context, 'Check your email',postActionName: 'ok');
            });

          },
          child: const Text(
            'Forget Password ?',
            style: TextStyle(
              color: Color(0xFF3F3D56),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
