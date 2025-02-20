import 'package:flutter/material.dart';
import 'package:keija_film_house/screens/movies_screen.dart';
import 'package:keija_film_house/screens/serie_screen.dart';
import 'package:keija_film_house/screens/short_film_screen.dart';
import 'package:keija_film_house/screens/downloads_screen.dart';
import 'package:keija_film_house/screens/me_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String selectedCategory = "Latest";
  final PageController _pageController = PageController();
  TextEditingController _searchController = TextEditingController();

  List<String> latestMovies = ['Olwatuka', 'Rain', 'Lala'];
  List<String> latestSeries = ['Prestige', 'Damalie', 'Sanyu'];
  List<String> latestShortFilms = ['Dogstory', 'Rolex', 'Shaka'];

  List<String> filteredMovies = [];
  List<String> filteredSeries = [];
  List<String> filteredShortFilms = [];

  @override
  void initState() {
    super.initState();
    filteredMovies = latestMovies;
    filteredSeries = latestSeries;
    filteredShortFilms = latestShortFilms;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // Change the page when an item is tapped
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/images/logo.jpg', height: 40),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle:
                        const TextStyle(color: Colors.black54, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.search, color: Colors.black),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(50.0), // Increased height for bigger tabs
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = "Latest";
                      filteredMovies = latestMovies;
                      filteredSeries = [];
                      filteredShortFilms = [];
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen()), // Navigate to Home screen
                    );
                  },
                  child: Text(
                    "Latest",
                    style: TextStyle(
                      fontSize: 18, // Increased font size
                      color: selectedCategory == "Latest"
                          ? Colors.orange
                          : Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = "Movies";
                      filteredMovies = latestMovies;
                      filteredSeries = [];
                      filteredShortFilms = [];
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MoviesScreen()), // Navigate to Movies screen
                    );
                  },
                  child: Text(
                    "Movies",
                    style: TextStyle(
                      fontSize: 18, // Increased font size
                      color: selectedCategory == "Movies"
                          ? Colors.orange
                          : Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = "Series";
                      filteredMovies = [];
                      filteredSeries = latestSeries;
                      filteredShortFilms = [];
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SerieScreen()), // Navigate to Series screen
                    );
                  },
                  child: Text(
                    "Series",
                    style: TextStyle(
                      fontSize: 18, // Increased font size
                      color: selectedCategory == "Series"
                          ? Colors.orange
                          : Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = "Short Films";
                      filteredMovies = [];
                      filteredSeries = [];
                      filteredShortFilms = latestShortFilms;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShortFilmScreen()), // Navigate to Short Films screen
                    );
                  },
                  child: Text(
                    "Short Films",
                    style: TextStyle(
                      fontSize: 18, // Increased font size
                      color: selectedCategory == "Short Films"
                          ? Colors.orange
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          // Home screen content
          Column(
            children: [
              // Carousel Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: [
                  ...latestMovies,
                  ...latestSeries,
                  ...latestShortFilms,
                ]
                    .map((movieName) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/$movieName.jpg'), // Update path to your images
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
              ),

              // Categories with Movies, Series, and Short Films
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Latest Movies Section
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Latest Movies",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: latestMovies.map((movieName) {
                                return Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/$movieName.jpg'), // Update path to your images
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(movieName,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // Latest Series Section
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Latest Series",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: latestSeries.map((seriesName) {
                                return Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/$seriesName.jpg'), // Update path to your images
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(seriesName,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // Latest Short Films Section
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Latest Short Films",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: latestShortFilms.map((shortFilmName) {
                                return Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/$shortFilmName.jpg'), // Update path to your images
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(shortFilmName,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          MoviesScreen(),
          DownloadsScreen(),
          MeScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // This will switch the pages
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download), label: 'Downloads'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
