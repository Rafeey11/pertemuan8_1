import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/post_provider.dart';

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  @override
void initState() {
  super.initState();
  Future.microtask(() {
    context.read<PostProvider>().fetchPost();
  });
}

  @override
  Widget build(BuildContext context) {

  final provider = context.watch<PostProvider>();
  return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Postingan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
body: Builder(
        builder: (context) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          }
          
          final posts = provider.posts;
          
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    leading: CircleAvatar(child: Text(post.id.toString())),
                  ),
                );
              },
            );
          },
        ),
      floatingActionButton: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Icon(Icons.home),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/photos');
            },
            child: Icon(Icons.photo),
          ),
        ],
      ),
    );
  }
}
