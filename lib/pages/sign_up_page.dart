import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelapp/component/back_button.dart';
import 'package:travelapp/component/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:travelapp/model/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = "";

  Future<bool> handleSignUp(User user) async {
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
      return true;
    } else {
      print("Sign up failed");
      setState(() {
        errorMessage = "Sign up failed. Please try again.";
      });
    }
    return false;
    // Response<User> dataResponse = Response.fromJson(data);
    // print(dataResponse.data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    errorMessage = "";
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
                    child: Text.rich(
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
                          const SizedBox(
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
                          Text(
                            errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[400],
                                  ),
                                  onPressed: () async {
                                    User user = User(
                                      username: usernameController.text,
                                      fullname: fullnameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      imageUrl: '',
                                    );
                                    //TODO: create account
                                    bool success = await handleSignUp(user);
                                    if (success) {
                                      Navigator.of(context).pop();
                                    }
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
