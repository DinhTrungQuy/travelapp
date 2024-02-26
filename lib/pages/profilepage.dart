import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/model/User.dart';
import 'package:travelapp/pages/LoginPage.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = true;
  bool loginStatus = false;
  String token = '';
  User user = User(username: '', password: '');
  void getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? '';
    if (token != '') {
      setState(() {
        loginStatus = true;
      });
    }
    setState(() {
      loading = false;
    });
  }

  Future<User> getUser() async {
    // TODO: Thieu 401 authentication
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
    final response = await http.get(
      Uri.parse('https://quydt.speak.vn/api/user'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode != 200) {
      loginStatus = false;
      return User(username: '', password: '');
    }
    return User.fromJson(jsonDecode(response.body));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getUser().then((value) => setState(() {
          user = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  height: 200,
                  child: Center(
                    child: loginStatus
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://quydt.speak.vn/image/default-user.png',
                                fit: BoxFit.contain,
                                width: 70,
                                height: 70,
                              ),
                              SizedBox(height: 10),
                              Text(
                                user.fullname,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Image.network(
                                'https://quydt.speak.vn/image/default-user.png',
                                fit: BoxFit.contain,
                                width: 70,
                                height: 70,
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Guest',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Login to see your profile',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: const Text('Login'),
                              ),
                            ],
                          ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('My Orders'),
                        leading: const Icon(Icons.shopping_bag_outlined),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('My Profile'),
                        leading: const Icon(Icons.person_outline),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('My Wishlist'),
                        leading: const Icon(Icons.favorite_border),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Help and support for your travel",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Settings'),
                        leading: const Icon(Icons.settings_outlined),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('About Us'),
                        leading: const Icon(Icons.info_outline),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Contact Us'),
                        leading: const Icon(Icons.contact_support_outlined),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                loginStatus
                    ? Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('Logout'),
                              leading: const Icon(Icons.logout),
                              onTap: () async {
                                setState(() {
                                  loginStatus = false;
                                });
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove("token");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 30),
                SizedBox(height: 70),
              ],
            ),
    );
  }
}
