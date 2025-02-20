import 'package:flutter/material.dart';
import 'package:keija_film_house/screens/short_film_details_screen.dart';

class ShortFilmScreen extends StatefulWidget {
  @override
  _ShortFilmScreenState createState() => _ShortFilmScreenState();
}

class _ShortFilmScreenState extends State<ShortFilmScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> shortFilms = [
    {
      'name': 'Lala',
      'image': 'assets/images/lala.jpg',
      'videoUrl': 'https://example.com/movie-trailer.mp4',
      'description': 'A mysterious passenger disrupts a peaceful train ride.',
      'genres': ['Mystery', 'Thriller'],
    },
    {
      'name': 'Kalabanda',
      'image': 'assets/images/kalabanda.jpg',
      'videoUrl': 'https://example.com/escape-trailer.mp4',
      'description':
          'A group of friends attempt a daring escape from a prison.',
      'genres': ['Action', 'Drama'],
    },
    {
      'name': 'Kikazi moto',
      'image': 'assets/images/kikazimoto.jpg',
      'videoUrl': 'https://example.com/escape-trailer.mp4',
      'description':
          'A group of friends attempt a daring escape from a prison.',
      'genres': ['Action', 'Drama'],
    },
    // Add more films here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('Selected index: $_selectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Short Films'),
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: shortFilms.length,
        itemBuilder: (context, index) {
          final film = shortFilms[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the detail screen and pass the film data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShortFilmDetailsScreen(film: film),
                ),
              );
            },
            child: Card(
              color: Colors.grey[800],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display image from assets
                  Image.asset(
                    film['image'],
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      film['name'], // Use title from the list
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

// Custom AppBar widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
