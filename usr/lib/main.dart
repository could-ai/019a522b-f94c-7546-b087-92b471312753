import 'package:flutter/material.dart';

void main() {
  runApp(const InstagramBetaApp());
}

class InstagramBetaApp extends StatelessWidget {
  const InstagramBetaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Beta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    FeedScreen(),
    PlaceholderScreen(title: 'Search'),
    PlaceholderScreen(title: 'Add Post'),
    PlaceholderScreen(title: 'Reels'),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Beta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // TODO: Navigate to DMs
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Post> _posts = [
    Post(
      username: 'user1',
      imageUrl: 'https://picsum.photos/400/400?random=1',
      caption: 'Beautiful sunset! 🌅',
      likes: 42,
      comments: ['Great shot!', 'Love it!'],
    ),
    Post(
      username: 'user2',
      imageUrl: 'https://picsum.photos/400/400?random=2',
      caption: 'Coffee time ☕',
      likes: 28,
      comments: ['Looks delicious!'],
    ),
    // Add more mock posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return PostWidget(post: post);
      },
    );
  }
}

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isLiked = false;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.likes;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/100/100?random=avatar'),
          ),
          title: Text(
            widget.post.username,
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // TODO: Show post options
            },
          ),
        ),
        Image.network(
          widget.post.imageUrl,
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.red : Colors.white,
              ),
              onPressed: _toggleLike,
            ),
            IconButton(
              icon: const Icon(Icons.comment, color: Colors.white),
              onPressed: () {
                // TODO: Navigate to comments
              },
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // TODO: Share post
              },
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.bookmark_border, color: Colors.white),
              onPressed: () {
                // TODO: Bookmark post
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '$_likeCount likes',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${widget.post.username} ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: widget.post.caption,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),n        ),
        if (widget.post.comments.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'View all ${widget.post.comments.length} comments',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class Post {
  final String username;
  final String imageUrl;
  final String caption;
  final int likes;
  final List<String> comments;

  Post({
    required this.username,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
  });
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title Screen',
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://picsum.photos/100/100?random=profile'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your Profile',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat('Posts', '10'),
              _buildStat('Followers', '150'),
              _buildStat('Following', '200'),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Edit profile
            },
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}