import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/model/AuthToken.dart';

import 'package:travelapp/model/LoginStatus.dart';
import 'package:travelapp/model/SelectedIndex.dart';
import 'package:travelapp/model/Wishlisted.dart';
import 'package:travelapp/model/cart.dart';
import 'package:travelapp/pages/HomePage.dart';
import 'package:travelapp/pages/NoficationPage.dart';
import 'package:travelapp/pages/ProfilePage.dart';
import 'package:travelapp/pages/WishlistPage.dart';
import 'package:travelapp/pages/searchpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = prefs.getString('token') ?? '';

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthToken()..setToken(data)),
      // Các providers khác
    ],
    child: MyApp(
      token: data,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String token;

  const MyApp({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedIndex()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Wishlist()),
        ChangeNotifierProvider(create: (context) => LoginStatus()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainPage(),
        debugShowCheckedModeBanner: false,
        routes: {},
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool loading = false;
  bool hasExpired = true;
  //TODO: set loading

  Future<void> initializeAsyncData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      String token = Provider.of<AuthToken>(context, listen: false).token;
      final _loginStatus = Provider.of<LoginStatus>(context, listen: false);

      if (token != "") {
        bool hasExpired = JwtDecoder.isExpired(token);
        if (hasExpired) {
          _loginStatus.setLoginStatus(false);
          token = '';
          await prefs.setString('token', '');
          await prefs.setString('userId', '');
          print('Token has expired');
        } else {
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          await prefs.setString('userId', decodedToken['Id']);
          _loginStatus.setLoginStatus(true);
          print("userId: " + decodedToken['Id']);
        }
      } else {
        _loginStatus.setLoginStatus(false);
        print('No token found');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initializeAsyncData();
  }

  @override
  Widget build(BuildContext context) {
    final _loginStatus = Provider.of<LoginStatus>(context);
    String token = Provider.of<AuthToken>(context).token;
    print('main.dart ${_loginStatus.isLoggedIn}');

    final List<Widget> _widgetOptions = [
      HomePage(token: token),
      Container(
        padding: EdgeInsets.only(top: 20),
        child: SearchPage(token: token),
      ),
      Container(
          padding: EdgeInsets.only(top: 20), child: WishlistPage(token: token)),
      ProfilePage(token: token),
    ];
    final _selectedIndex = Provider.of<SelectedIndex>(context);

    return loading
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red[400],
              scrolledUnderElevation: 0,
              title: Text(
                'Travel App',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              actions: [
                // Container(
                //   margin: EdgeInsets.only(right: 15),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => NoficationPage()));
                //     },
                //     child: Icon(Icons.notifications_none_outlined,
                //         color: Colors.white),
                //   ),
                // ),
              ],
            ),
            body: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                _widgetOptions.elementAt(_selectedIndex.index),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(44),
                    child: GNav(
                      backgroundColor: Colors.redAccent.shade200,
                      color: Colors.white,
                      activeColor: Colors.white,
                      tabBackgroundColor: Colors.red.shade600,
                      padding: EdgeInsets.all(16),
                      gap: 8,
                      selectedIndex: _selectedIndex.index,
                      onTabChange: (index) {
                        _selectedIndex.setIndex(index);
                      },
                      tabs: [
                        GButton(
                          icon: Icons.home_outlined,
                          text: 'Home',
                        ),
                        GButton(
                          icon: Icons.search,
                          text: 'Search',
                        ),
                        GButton(
                          icon: Icons.favorite_border,
                          text: 'Wishlist',
                        ),
                        GButton(
                          icon: Icons.person_outline_rounded,
                          text: 'Profile',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
