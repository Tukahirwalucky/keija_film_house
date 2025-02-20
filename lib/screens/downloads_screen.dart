import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_filex/open_filex.dart';

class DownloadsScreen extends StatefulWidget {
  @override
  _DownloadsScreenState createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  List<String> _downloadedMovies = [];
  List<String> _downloadedSeries = [];
  List<String> _downloadedShortFilms = [];

  @override
  void initState() {
    super.initState();
    _loadDownloads();
  }

  // Load stored downloads from SharedPreferences
  Future<void> _loadDownloads() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _downloadedMovies = prefs.getStringList('downloadedMovies') ?? [];
      _downloadedSeries = prefs.getStringList('downloadedSeries') ?? [];
      _downloadedShortFilms = prefs.getStringList('downloadedShortFilms') ?? [];
    });
  }

  // Open file when clicked
  void _playVideo(String filePath) {
    OpenFilex.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Downloaded Movies"),
            _buildDownloadList(_downloadedMovies),
            _buildSectionTitle("Downloaded Series"),
            _buildDownloadList(_downloadedSeries),
            _buildSectionTitle("Downloaded Short Films"),
            _buildDownloadList(_downloadedShortFilms),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Downloaded items list
  Widget _buildDownloadList(List<String> items) {
    return items.isEmpty
        ? Text("No downloads available",
            style: TextStyle(color: Colors.white70))
        : Column(
            children: items
                .map((filePath) => ListTile(
                      title: Text(filePath.split('/').last,
                          style: TextStyle(color: Colors.white)),
                      leading: Icon(Icons.movie, color: Colors.white),
                      trailing: IconButton(
                        icon: Icon(Icons.play_arrow, color: Colors.orange),
                        onPressed: () => _playVideo(filePath),
                      ),
                    ))
                .toList(),
          );
  }
}
