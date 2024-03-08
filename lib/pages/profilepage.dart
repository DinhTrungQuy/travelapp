// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travelapp/model/LoginStatus.dart';
import 'package:travelapp/model/SelectedIndex.dart';
import 'package:travelapp/model/User.dart';
import 'package:travelapp/pages/EditProfilePage.dart';
import 'package:travelapp/pages/LoginPage.dart';
import 'package:travelapp/pages/MyTourPage.dart';

class ProfilePage extends StatefulWidget {
  final String token;
  
  const ProfilePage({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = true;

  User user = User(username: '', password: '');

  Future<User> getUser() async {
    final response = await http.get(
      Uri.parse('https://quydt.speak.vn/api/user'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + widget.token,
      },
    );
    if (response.statusCode != 200) {
      return User(username: '', password: '');
    }
    User userData = User.fromJson(jsonDecode(response.body));
    return userData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) => setState(() {
          user = value;
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = Provider.of<SelectedIndex>(context, listen: true);
    final _loginStatus = Provider.of<LoginStatus>(context, listen: true);
    print('ProfilePage.dart: ${_loginStatus.isLoggedIn}');
    print('ProfilePage.dart: ${widget.token}');
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  height: 200,
                  child: Center(
                    child: _loginStatus.isLoggedIn
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70)),
                                child: Image.network(
                                  user.imageUrl != ''
                                      ? user.imageUrl
                                      : 'https://quydt.speak.vn/images/default-user.png',
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Hi ${user.fullname.toUpperCase()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  'https://quydt.speak.vn/images/default-user.png',
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
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
                        title: const Text('My Tour'),
                        leading: const Icon(Icons.card_travel_outlined),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyTourPage(token: widget.token)));
                        },
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage(
                                        user: user,
                                      )));
                        },
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
                        onTap: () {
                          _selectedIndex.setIndex(2);
                        },
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
                _loginStatus.isLoggedIn
                    ? Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('Logout'),
                              leading: const Icon(Icons.logout),
                              onTap: () async {
                                print(_loginStatus.isLoggedIn);
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove("token");
                                prefs.remove("userId");

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                                setState(() {
                                  _loginStatus.setLoginStatus(false);
                                  print('rerendering');
                                });
                                print(_loginStatus.isLoggedIn);
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
