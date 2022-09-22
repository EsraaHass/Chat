import 'package:chat/firebase_options.dart';
import 'package:chat/view/login/login.dart';
import 'package:chat/view/register/register.dart';
import 'package:chat/view/screens/AddRoom.dart';
import 'package:chat/view/screens/Chat.dart';
import 'package:chat/view/screens/home_screen.dart';
import 'package:chat/view/shared/constant/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Register.routeName,
      routes: {
        Register.routeName: (_) => Register(),
        Login.routeName: (_) => Login(),
        HomeScreen.routeName: (_) => HomeScreen(),
        AddRoom.routeName: (_) => AddRoom(),
        Chat.routeName: (_) => Chat(),
      },
      theme: MyTheme.lightTheme,
    );
  }
}
