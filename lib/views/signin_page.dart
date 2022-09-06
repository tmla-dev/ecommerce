import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../view_models/auth_provider.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordConroller = TextEditingController();

  /// to check password complexity
  // final passwordValidator = MultiValidator([
  //   RequiredValidator(errorText: 'password is required'),
  //   MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  //   // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  // ]);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90,
            ),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///title
                  Center(
                    child: Text(
                      'Welcome!',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: deviceWidth * .2,
                  ),

                  ///Username container
                  Container(
                    width: deviceWidth * .90,
                    height: deviceWidth * .14,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: usernameController,
                          style: TextStyle(
                            fontSize: deviceWidth * .040,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Username',
                          ),
                          validator: RequiredValidator(
                              errorText: 'Username is required'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceWidth * .06,
                  ),

                  ///password container
                  Container(
                    width: deviceWidth * .90,
                    height: deviceWidth * .14,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordConroller,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: deviceWidth * .040,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Password',
                          ),
                          // validator: RequiredValidator(
                          //     errorText: 'Password is required'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceWidth * .15,
                  ),

                  ///login button
                  GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<AuthProvider>().loginUser(usernameController.text, passwordConroller.text);
                      } else {
                        print('validation failed');
                      }
                    },
                    child: Container(
                      width: deviceWidth * .90,
                      height: deviceWidth * .14,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6962E7),
                        borderRadius: BorderRadius.all(Radius.circular(5),),
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceWidth * .040,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
