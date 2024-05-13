import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:houseenterainment/ui/screens/category_screen/category_view.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../login_screen/login_view.dart';



class SplashScreen extends StatefulWidget {
  static const String routeName = 'splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2),(){
      login();
    });
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splash.png'), fit: BoxFit.fill)),
    );
  }

  void login() async {
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);

    if (FirebaseAuth.instance.currentUser != null) {
      var user = await authProvider.getUserFromDataBase();
      if (user != null) {
        Navigator.pushReplacementNamed(context, CategoryScreen.routeName);
        return;
      }
    }
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}