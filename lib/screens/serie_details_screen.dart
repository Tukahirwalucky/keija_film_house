import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'custom_app_bar.dart';

// Video player widget to display video for each episode
class EpisodeVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const EpisodeVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _EpisodeVideoPlayerState createState() => _EpisodeVideoPlayerState();
}

class _EpisodeVideoPlayerState extends State<EpisodeVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Container(); // Show a loading indicator while the video is initializing
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class SeriesDetailScreen extends StatefulWidget {
  final String seriesTitle;
  final String seriesDescription;
  final List<String> genres;
  final int numberOfSeasons;
  final List seasons;
  final String image;

  SeriesDetailScreen({
    required this.seriesTitle,
    required this.seriesDescription,
    required this.genres,
    required this.numberOfSeasons,
    required this.seasons,
    required this.image,
  });

  @override
  _SeriesDetailScreenState createState() => _SeriesDetailScreenState();
}

class _SeriesDetailScreenState extends State<SeriesDetailScreen> {
  List<String> downloadProgress = List.generate(
    100,
    (index) => 'Downloading episode ${index + 1}...',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: widget.seriesTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              widget.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250, // Adjust the height as necessary
            ),
            const SizedBox(height: 16),
            Text(
              widget.seriesDescription,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Genres: ${widget.genres.join(', ')}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Seasons',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.numberOfSeasons,
                itemBuilder: (context, seasonIndex) {
                  var season = widget.seasons[seasonIndex];
                  return ExpansionTile(
                    title: Text(
                      'Season ${season['seasonNumber']}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: season['episodes'].length,
                        itemBuilder: (context, episodeIndex) {
                          var episode = season['episodes'][episodeIndex];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                // Video player instead of image
                                EpisodeVideoPlayer(
                                    videoUrl: episode['videoUrl']),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    episode['title'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.download,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                // Simulate download progress
                                setState(() {
                                  downloadProgress[episodeIndex] =
                                      'Downloaded!'; // Mark as downloaded
                                });
                              },
                            ),
                            subtitle: Text(
                              downloadProgress[episodeIndex],
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
