import 'package:chat/repository/repository_impl.dart';
import 'package:chat/view/base/base.dart';
import 'package:chat/view/login/login.dart';
import 'package:chat/view/register/buildTextFormField.dart';
import 'package:chat/view/register/checkEmailValid.dart';
import 'package:chat/view/screens/home_screen.dart';
import 'package:chat/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static const String routeName = 'Home';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends BaseState<Register, RegisterViewModel>
    implements RegisterNavigator {
  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  var emailController = TextEditingController();

  var passowrdController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel(repository: ChatRepository());
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Create Acount',
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
                            BuildTextFormField('First Name',
                                firstNameController, 'please enter first name'),
                            BuildTextFormField('Last Name', lastNameController,
                                'please enter last name'),
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
                        CreateAcount();
                      },
                      child: Text('Create Account')),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Login.routeName);
                    },
                    child: Text('Already Have Account ?'),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void CreateAcount() {
    if (formKey.currentState!.validate() == false) return null;
    viewModel.creatAccount(emailController.text, passowrdController.text,
        firstNameController.text, lastNameController.text);
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
