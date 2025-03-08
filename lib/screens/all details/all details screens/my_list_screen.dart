import 'package:flutter/material.dart';
import 'package:netflix_app/screens/all%20details/api/service.dart';
import 'package:netflix_app/screens/all%20details/widgets/media_card.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  final TMDBService _tmdbService = TMDBService();
  late Future<List<Map<String, dynamic>>> _myListFuture;

  @override
  void initState() {
    super.initState();
    _myListFuture = _loadMyList();
  }

  Future<List<Map<String, dynamic>>> _loadMyList() async {
    try {
      return await _tmdbService.getMyList();
    } catch (e) {
      print('Error loading my list: $e');
      rethrow;
    }
  }

  Future<void> _refreshList() async {
    setState(() {
      _myListFuture = _loadMyList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'My List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _myListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.red),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshList,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final myList = snapshot.data ?? [];

            if (myList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.list_alt,
                      color: Colors.white54,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your list is empty',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add movies and TV shows to your list',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                final item = myList[index];
                return MediaCard(
                  id: item['id'] ?? 0,
                  title: item['title'] ?? item['name'] ?? 'Unknown',
                  posterPath: item['poster_path'] ?? '',
                  mediaType: item['media_type'] ?? 'movie',
                  onListUpdated: _refreshList,
                );
              },
            );
          },
        ),
      ),
    );
  }
}