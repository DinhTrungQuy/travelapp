import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/component/custom_text_field.dart';
import 'package:travelapp/model/auth_token.dart';
import 'package:travelapp/model/login_status.dart';
import 'package:travelapp/model/selected_index.dart';
import 'package:travelapp/pages/sign_up_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage = "";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<bool> handleLogin(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://quydt.speak.vn/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      await prefs.setString("token", response.body);
      return true;
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", "");
      errorMessage = "Username or password is incorrect";
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = Provider.of<SelectedIndex>(context, listen: true);
    final loginStatus = Provider.of<LoginStatus>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.red[400],
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              const Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
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
                ],
              )),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Login',
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
                      label: 'Enter your username',
                    ),
                    CustomTextField(
                      controller: passwordController,
                      icon: Icons.lock,
                      label: 'Enter your password',
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                        ),
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await handleLogin(usernameController.text.trimRight(),
                                  passwordController.text)
                              .then((value) {
                            Provider.of<AuthToken>(context, listen: false)
                                .setToken(prefs.getString("token")!);
                            setState(() {
                              loginStatus.setLoginStatus(value);
                            });
                          });
                          //TODO: login
                          if (loginStatus.isLoggedIn == true) {
                            Navigator.pop(context);
                            selectedIndex.setIndex(0);
                          }
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: const Text(
                    //       'Forgot your password?',
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Text('Or'),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)),
                            side: const BorderSide(
                              width: 2,
                            )),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const SignUpPage();
                            }),
                          );
                        },
                        child: const Text(
                          'Create account',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
