import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final List<BlogPost> blogPosts = [
    BlogPost(
      id: 1,
      title: 'Getting Started with Flutter',
      author: 'John Doe',
      date: '2024-01-15',
      content: 'Learn the basics of Flutter development and create your first app.',
      imageUrl: 'https://via.placeholder.com/300x200',
    ),
    BlogPost(
      id: 2,
      title: 'State Management in Flutter',
      author: 'Jane Smith',
      date: '2024-01-10',
      content: 'Explore different state management solutions for Flutter apps.',
      imageUrl: 'https://via.placeholder.com/300x200',
    ),
    BlogPost(
      id: 3,
      title: 'Building Responsive UIs',
      author: 'Mike Johnson',
      date: '2024-01-05',
      content: 'Create beautiful and responsive user interfaces with Flutter.',
      imageUrl: 'https://via.placeholder.com/300x200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: blogPosts.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return BlogPostCard(post: blogPosts[index]);
        },
      ),
    );
  }
}

class BlogPostCard extends StatelessWidget {
  final BlogPost post;

  const BlogPostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.network(
              post.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      post.author,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      post.date,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  post.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Read more: ${post.title}')),
                      );
                    },
                    child: const Text('Read More'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogPost {
  final int id;
  final String title;
  final String author;
  final String date;
  final String content;
  final String imageUrl;

  BlogPost({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    required this.imageUrl,
  });
}
