import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'GatxController.dart';
import 'Splashscreen.dart';
import 'categories.dart';
import 'channels.dart';
import 'favouriteController.dart';
import 'favouritemovie.dart';
import 'movie_list_widget.dart';
import 'movie_model.dart';
import 'movie_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());
  final FavoriteController favouriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/", // Set initial route to "/"
      initialBinding: BindingsBuilder(() {
        Get.put(FavoriteController());
        Get.put(MovieController());
      }),

      getPages: [
        GetPage(
            name: "/",
            page: () => SplashScreen()), // Define the route for HomeScreen
        GetPage(name: "/FavoriteScreen", page: () => FavoriteScreen()),
        // Add more pages as needed
      ],
      title: 'Movie Fetch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie & Shows'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.cast),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      drawer: Drawer(
          // Drawer content...
          ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          MovieListWidget(),
          FavoriteScreen(),
          categories(),
          channels()
          // Add more pages as needed
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.grey,
        fixedColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi_channel_sharp),
            label: 'Channels',
          ),
          // Add more items as needed
        ],
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
