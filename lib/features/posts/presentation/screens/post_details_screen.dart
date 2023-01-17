import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';

import '../widgets/post_detail_screen/post_detail_widget.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;
  const PostDetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text('Post details'));
  Widget _buildBody() => Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: PostDetailWidget(post: post),
        ),
      );
}
