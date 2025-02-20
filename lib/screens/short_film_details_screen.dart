import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortFilmDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> film; // Accepting a film as a parameter

  ShortFilmDetailsScreen({required this.film});

  @override
  _ShortFilmDetailsScreenState createState() => _ShortFilmDetailsScreenState();
}

class _ShortFilmDetailsScreenState extends State<ShortFilmDetailsScreen> {
  late VideoPlayerController _controller;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String _downloadStatus = "Download";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.film['videoUrl'])
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

  void _startDownload() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _downloadStatus = "Downloading...";
    });

    while (_downloadProgress < 1.0) {
      await Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _downloadProgress += 0.05;
        });
      });
    }

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
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.film['name'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Center(child: CircularProgressIndicator()),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.film['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.film['description'],
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Genres: ${widget.film['genres'].join(', ')}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
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
                  ElevatedButton(
                    onPressed: _isDownloading ? null : _startDownload,
                    child: Text(_downloadStatus),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 166, 0),
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
