import 'package:chat/repository/repository_impl.dart';
import 'package:chat/view/base/base.dart';
import 'package:chat/view/register/checkEmailValid.dart';
import 'package:chat/view/register/register.dart';
import 'package:chat/view/screens/home_screen.dart';
import 'package:chat/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String routeName = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends BaseState<Login, LoginViewModel>
    implements LoginNavigator {
  var emailController = TextEditingController();

  var passowrdController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel(repository: ChatRepository());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
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
      ),
    );
  }

  void signIn() {
    if (formKey.currentState!.validate() == false) return null;
    viewModel.login(emailController.text, passowrdController.text);
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
