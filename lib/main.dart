import 'package:chat/firebase_options.dart';
import 'package:chat/presentation_layer/login/login.dart';
import 'package:chat/presentation_layer/register/register.dart';
import 'package:chat/presentation_layer/theme.dart';
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
      },
      theme: MyTheme.lightTheme,
    );
  }
}
