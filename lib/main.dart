import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/model/selected_index.dart';
import 'package:travelapp/pages/add-to-cart.dart';
import 'package:travelapp/pages/favoritepage.dart';
import 'package:travelapp/pages/homepage.dart';
import 'package:travelapp/pages/profilepage.dart';
import 'package:travelapp/pages/searchpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedIndex()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/addtocart': (context) => const AddToCartPage(),
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _widgetOptions = [
    HomePage(),
    SearchPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = Provider.of<SelectedIndex>(context, listen: true);
    void navigateToCart() {
      Navigator.pushNamed(context, '/addtocart');
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.red[400],
        title: Text(
          'Travel App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red[400],
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: navigateToCart,
              child: Icon(Icons.notifications_none_outlined,
                  color: Colors.red[400]),
            ),
          ),
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
