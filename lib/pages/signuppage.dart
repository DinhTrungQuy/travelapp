import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelapp/component/back-button.dart';
import 'package:travelapp/component/custom-text-field.dart';
import 'package:http/http.dart' as http;
import 'package:travelapp/model/user.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController fullnameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void handleSignUp(User user) async {
    final response =
        await http.post(Uri.parse("https://quydt.speak.vn/api/auth/register"),
            headers: <String, String>{
              'Content-type': 'application/json; charset=utf-8',
            },
            body: jsonEncode(<String, String>{
              "username": user.username,
              "password": user.password,
              "email": user.email,
              "fullname": user.fullname,
              "phone": user.phone,
              "role": user.role,
            }));
    if (response.statusCode == 200) {
      print("Sign up success");
    } else {
      print("Sign up failed");
    }
    // Response<User> dataResponse = Response.fromJson(data);
    // print(dataResponse.data);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(children: [
                const Expanded(
                  child: Center(
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 40,
                        ),
                        children: [
                          TextSpan(
                            text: 'Travel ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'App',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //Formulario
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: usernameController,
                            icon: Icons.person,
                            label: 'User Name',
                          ),
                          CustomTextField(
                            controller: fullnameController,
                            icon: Icons.badge,
                            label: 'Full Name',
                          ),
                          CustomTextField(
                            controller: phoneController,
                            icon: Icons.phone,
                            label: 'Phone Number',
                            // inputFormatters: [celularFormatter],
                          ),
                          CustomTextField(
                            controller: emailController,
                            icon: Icons.mail,
                            label: 'Email',
                          ),
                          CustomTextField(
                            controller: passwordController,
                            icon: Icons.lock,
                            label: 'Password',
                            isSecret: true,
                          ),
                          SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[400],
                                  ),
                                  onPressed: () {
                                    User user = User(
                                      username: usernameController.text,
                                      fullname: fullnameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      imageUrl: '',
                                    );
                                    //TODO: create account
                                    handleSignUp(user);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Create account',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )))
                        ])),
              ]),
              Positioned(
                left: 16,
                top: 16,
                child: SafeArea(child: BackArrowButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
