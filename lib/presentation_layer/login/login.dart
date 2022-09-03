import 'package:chat/presentation_layer/dialogDetails.dart';
import 'package:chat/presentation_layer/register/checkEmailValid.dart';
import 'package:chat/presentation_layer/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String routeName = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();

  var passowrdController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Login',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: size * .25,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.bodySmall,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'please enter email address';
                              }
                              if (!Validation.isValidateEmail(text)) {
                                return 'please enter a valid email';
                              }
                              return null;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 14,
                                        color: Color(0xFF797979))),
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.bodySmall,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'please enter password';
                              }
                              if (text.length < 6) {
                                return 'password should be at least 6 chars';
                              }
                              return null;
                            },
                            controller: passowrdController,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 14,
                                        color: Color(0xFF797979))),
                          ),
                          // SizedBox(height: size*.25,),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: Text('Login')),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Register.routeName);
                  },
                  child: Text('Or Create Account ?'),
                )
              ],
            )),
      ),
    );
  }

  var authServices = FirebaseAuth.instance;

  void signIn() {
    if (formKey.currentState!.validate() == false) {
      return null;
    }
    showLoadingDialog(context, 'Loading...');
    authServices
        .signInWithEmailAndPassword(
            email: emailController.text, password: passowrdController.text)
        .then((UserCredential) {
      hideLoadingDialog(context);
      showMassege(context, UserCredential.user?.email ?? '');
    }).onError((error, stackTrace) {
      hideLoadingDialog(context);
      showMassege(context, error.toString());
    });
  }
}
