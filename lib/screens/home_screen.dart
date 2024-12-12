import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keija Film House',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keija Film House'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with profile image URL
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          // Free Downloads Section
          _buildFreeDownloadSection(),
          const SizedBox(height: 10),
          // Latest Movies Section
          _buildSectionTitle('Latest Movies'),
          _buildHorizontalList([
            'Olwatuka',
            'Kash Rain',
            'Lala',
          ]),
          const SizedBox(height: 10),
          // Latest Series Section
          _buildSectionTitle('Latest Series'),
          _buildHorizontalList([
            'Prestige',
            'Damalo',
            'Sanyu',
          ]),
          const SizedBox(height: 10),
          // Latest Cartoons Section
          _buildSectionTitle('Latest Cartoons'),
          _buildHorizontalList([
            'Kalabanda',
            'Iwaju',
            'Shaka',
          ]),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFreeDownloadSection() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage('https://via.placeholder.com/300x100'), // Replace with an actual banner image
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        'Free Downloads Available',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildHorizontalList(List<String> titles) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return _buildCard(titles[index]);
        },
      ),
    );
  }

  Widget _buildCard(String title) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage('https://via.placeholder.com/100x150'), // Replace with movie poster image
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Download'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.orange,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.short_text, color: Colors.black),
          label: 'Short Film',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.download, color: Colors.black),
          label: 'Downloads',
        ),
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
    );
  }
}
