import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'movie_details_screen.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  // List of movies for the grid view
  List<Map<String, dynamic>> movies = [
    {
      'name': 'The Matron',
      'image': 'assets/images/matron.jpg',
      'videoUrl': 'https://example.com/movie-trailer.mp4',
      'description': 'A gripping tale of a young woman\'s journey.',
      'genres': ['Drama', 'Thriller'],
    },
    {
      'name': 'The Passenger',
      'image': 'assets/images/passenger.jpg',
      'videoUrl': 'https://example.com/movie-trailer.mp4',
      'description': 'A mysterious passenger disrupts a peaceful train ride.',
      'genres': ['Mystery', 'Thriller'],
    },
    // Add more movies here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 movies per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(
                      movieTitle: movies[index]['name']!,
                      movieVideoUrl: movies[index]['videoUrl']!,
                      movieDescription: movies[index]['description']!,
                      movieGenres: List<String>.from(movies[index]['genres']!),
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        movies[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movies[index]['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
