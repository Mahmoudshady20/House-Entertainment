import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:houseenterainment/ui/screens/register_screen/component/confirm_text_field.dart';
import 'package:houseenterainment/ui/screens/register_screen/component/name_text_field.dart';
import 'package:houseenterainment/ui/screens/register_screen/component/sign_button.dart';
import 'package:provider/provider.dart';

import '../../../database/model/user.dart';
import '../../../database/mydatabase.dart';
import '../../../provider/auth_provider.dart';
import '../../component/utils/dialog_utils.dart';
import '../../component/shared/email_background.dart';
import '../../component/shared/email_body.dart';
import '../../component/shared/email_header.dart';
import '../../component/shared/email_text_field.dart';
import '../../component/shared/navigation_button.dart';
import '../../component/shared/password_text_field.dart';
import '../login_screen/login_view.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AllBackground(
        child: Form(
      key: formKey,
      child: AllBody(
        children: [
          const EmailHeader(word: 'Sign Up Details'),
          NameTextField(nameController: nameController),
          EmailTextField(emailController: emailController),
          PasswordTextField(passwordController: passwordController),
          ConfirmTextField(
              confirmPasswordController: confirmPasswordController,
              passwordController: passwordController),
          SignButton(
            onPressed: () {
              register();
            },
            formKey: formKey,
          ),
          const NavigationButton(
              word: 'Or Login', routeName: LoginScreen.routeName),
        ],
      ),
    ));
  }

  FirebaseAuth authServices = FirebaseAuth.instance;
  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    DialogUtils.showLoadingDialog(context, 'Loading...');
    try {
      var result = await authServices.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      MyUser myUser = MyUser(
          id: result.user?.uid,
          email: emailController.text,
          name: nameController.text
      );
      await MyDataBase.addUser(myUser);
      var provider = Provider.of<AuthProviderr>(context,listen: false);
      provider.updateUser(myUser);
      DialogUtils.hideDialog(context);
      DialogUtils.showSuccess(context, 'user registered successfully',
          postActionName: 'ok', posAction: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }, dismissible: false);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      DialogUtils.showFailed(context, errorMessage, postActionName: 'ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      DialogUtils.showFailed(context, errorMessage,
          postActionName: 'cancel', negActionName: 'Try Again', negAction: () {
        register();
      });
    }
  }
}
