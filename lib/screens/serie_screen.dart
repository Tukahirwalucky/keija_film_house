import 'package:flutter/material.dart';
import 'serie_details_screen.dart';
import 'home_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Text(title, style: TextStyle(color: Colors.white)),
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

class SerieScreen extends StatefulWidget {
  @override
  _SerieScreenState createState() => _SerieScreenState();
}

class _SerieScreenState extends State<SerieScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: 'Series'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: seriesList.length,
          itemBuilder: (context, index) {
            return buildSeriesCard(seriesList[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

  Widget buildSeriesCard(Map<String, dynamic> series) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeriesDetailScreen(
              seriesTitle: series['name'],
              seriesDescription: series['description'],
              genres: series['genres'],
              numberOfSeasons: series['seasons'].length,
              seasons: series['seasons'],
              image: series['image'],
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(series['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            series['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> seriesList = [
  {
    'name': 'Damalie',
    'image': 'assets/images/damalie.jpg',
    'description': 'A gripping tale of a young woman\'s journey.',
    'genres': ['Drama', 'Thriller'],
    'seasons': [
      {
        'seasonNumber': 1,
        'episodes': List.generate(
          10,
          (index) => {
            'title': 'Episode ${index + 1}',
            'videoUrl': 'https://example.com/episode${index + 1}.mp4',
            'image': 'assets/images/damalie.jpg',
          },
        ),
      },
      {
        'seasonNumber': 2,
        'episodes': List.generate(
          8,
          (index) => {
            'title': 'Episode ${index + 1}',
            'videoUrl': 'https://example.com/episode${index + 11}.mp4',
            'image': 'assets/images/damalie.jpg',
          },
        ),
      },
    ],
  },
  {
    'name': 'Prestige',
    'image': 'assets/images/prestige.jpg',
    'description': 'A mysterious passenger disrupts a peaceful train ride.',
    'genres': ['Mystery', 'Thriller'],
    'seasons': [
      {
        'seasonNumber': 1,
        'episodes': List.generate(
          10,
          (index) => {
            'title': 'Episode ${index + 1}',
            'videoUrl': 'https://example.com/prestige-ep${index + 1}.mp4',
            'image': 'assets/images/prestige.jpg',
          },
        ),
      },
      {
        'seasonNumber': 2,
        'episodes': List.generate(
          10,
          (index) => {
            'title': 'Episode ${index + 1}',
            'videoUrl': 'https://example.com/prestige-ep${index + 11}.mp4',
            'image': 'assets/images/prestige.jpg',
          },
        ),
      },
      {
        'seasonNumber': 3,
        'episodes': List.generate(
          10,
          (index) => {
            'title': 'Episode ${index + 1}',
            'videoUrl': 'https://example.com/prestige-ep${index + 21}.mp4',
            'image': 'assets/images/prestige.jpg',
          },
        ),
      },
    ],
  },
];
