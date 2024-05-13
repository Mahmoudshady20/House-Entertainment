import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:houseenterainment/database/mydatabase.dart';
import 'package:houseenterainment/ui/component/shared/email_background.dart';
import 'package:houseenterainment/ui/component/utils/dialog_utils.dart';
import 'package:houseenterainment/ui/screens/category_screen/category_view.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth_provider.dart';
import '../../component/shared/email_body.dart';
import '../../component/shared/email_text_field.dart';
import '../../component/shared/navigation_button.dart';
import '../../component/shared/password_text_field.dart';
import '../register_screen/register_view.dart';
import 'components/forget_button.dart';
import 'components/login_button.dart';
import 'components/login_header.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AllBackground(
      child: Form(
        key: formKey,
        child: AllBody(
          children: [
            const LoginHeader(
              word: 'Login Details',
            ),
            EmailTextField(emailController: emailController),
            PasswordTextField(passwordController: passwordController),
            ForgetButton(
              emailAddress: emailController.text,
              authServices: authServices,
            ),
            LoginButton(
              onPressed: () {
                login();
              },
            ),
            const NavigationButton(
              word: 'Or Sign Up',
              routeName: RegisterScreen.routeName,
            )
          ],
        ),
      ),
    );
  }

  FirebaseAuth authServices = FirebaseAuth.instance;
  login() async {
    if (formKey.currentState!.validate() == false) {
      return;
    }
    try {
      DialogUtils.showLoadingDialog(context, 'Loading...');
      final credential = await authServices.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var myUser = await MyDataBase.readUser(credential.user?.uid ?? '');
      if (myUser == null) {
        // user is authenticated but not exists in the database
        DialogUtils.hideDialog(context);
        DialogUtils.showFailed(context, "error. can't find user in db",
            postActionName: 'ok');
        return;
      }
      var provider = Provider.of<AuthProviderr>(context, listen: false);
      provider.updateUser(myUser);
      DialogUtils.hideDialog(context);
      DialogUtils.showSuccess(context, 'user logged in successfully',
          dismissible: false,
          postActionName: 'ok', posAction: () {
        Navigator.pushReplacementNamed(context, CategoryScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showFailed(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        DialogUtils.showFailed(
            context, 'Wrong password provided for that user.');
      } else {
        DialogUtils.showFailed(
            context, 'Please make sure that the email or password is not incorrect.');
      }
    }
  }
}
