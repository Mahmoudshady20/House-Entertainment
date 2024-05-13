import 'package:flutter/material.dart';
import 'package:houseenterainment/provider/auth_provider.dart';
import 'package:houseenterainment/provider/category_provider.dart';
import 'package:houseenterainment/provider/item_provider.dart';
import 'package:houseenterainment/ui/screens/category_screen/category_edit/category_edit.dart';
import 'package:houseenterainment/ui/screens/category_screen/category_view.dart';
import 'package:houseenterainment/ui/screens/item_screen/add_item/add_item_screen.dart';
import 'package:houseenterainment/ui/screens/item_screen/edit_item/item_edit.dart';
import 'package:houseenterainment/ui/screens/item_screen/item_view.dart';
import 'package:houseenterainment/ui/screens/login_screen/login_view.dart';
import 'package:houseenterainment/ui/screens/register_screen/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:houseenterainment/ui/screens/splah_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProviderr>(create: (context) => AuthProviderr(),),
        ChangeNotifierProvider<CategoryProvider>(create: (context) => CategoryProvider(),),
        ChangeNotifierProvider<ItemProvider>(create: (context) => ItemProvider(),),
      ],
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        ItemScreen.routeName : (context) => const ItemScreen(),
        CategoryEdit.routeName : (context) => CategoryEdit(),
        ItemEdit.routeName : (context) => const ItemEdit(),
        RegisterScreen.routeName : (context) => const RegisterScreen(),
        LoginScreen.routeName : (context) => const LoginScreen(),
        CategoryScreen.routeName : (context) => const CategoryScreen(),
        SplashScreen.routeName : (context) => const SplashScreen(),
        AddItemScreen.routeName : (context) => const AddItemScreen()
      },
    );
  }
}
