import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieTitle;
  final String movieVideoUrl;
  final String movieDescription;
  final List<String> movieGenres;

  MovieDetailScreen({
    required this.movieTitle,
    required this.movieVideoUrl,
    required this.movieDescription,
    required this.movieGenres,
  });

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late VideoPlayerController _controller;
  bool _isDownloading = false;
  double _downloadProgress = 0.0; // Progress value
  String _downloadStatus = "Download"; // Button text

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.movieVideoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Simulate download process
  void _startDownload() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _downloadStatus = "Downloading...";
    });

    // Simulate the download by updating the progress over time
    while (_downloadProgress < 1.0) {
      await Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _downloadProgress += 0.05; // Update progress
        });
      });
    }

    // Once download is complete
    setState(() {
      _downloadStatus = "Download Complete";
      _isDownloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          widget.movieTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video player section
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Center(child: CircularProgressIndicator()),

            // Movie details section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie title
                  Text(
                    widget.movieTitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Movie description
                  Text(
                    widget.movieDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Movie genres
                  Text(
                    'Genres: ${widget.movieGenres.join(', ')}',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Download progress indicator
                  _isDownloading
                      ? Column(
                          children: [
                            LinearProgressIndicator(
                              value: _downloadProgress,
                              color: Colors.orange,
                              backgroundColor: Colors.grey[800],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${(_downloadProgress * 100).toStringAsFixed(0)}% Downloaded",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                      : Container(),

                  // Download button
                  ElevatedButton(
                    onPressed: _isDownloading ? null : _startDownload, // Disable button during download
                    child: Text(_downloadStatus),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 166, 0), // Teal color
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
