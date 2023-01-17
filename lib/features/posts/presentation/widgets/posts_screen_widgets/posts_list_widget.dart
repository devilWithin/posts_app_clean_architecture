import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/presentation/screens/post_details_screen.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_add_update_screen.dart';

import '../../../domain/entities/post.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailsScreen(
                  post: posts[index],
                ),
              ),
            );
          },
        );
      }),
      itemCount: posts.length,
      separatorBuilder: (context, index) {
        return const Divider(thickness: 2);
      },
    );
  }
}
