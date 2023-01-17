import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/presentation/bloc/get_all_posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_add_update_screen.dart';

import '../widgets/posts_screen_widgets/message_display_widget.dart';
import '../widgets/posts_screen_widgets/posts_list_widget.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _postsScreenAppbar(),
      body: _buildBody(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  AppBar _postsScreenAppbar() => AppBar(title: const Text("Posts"));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: () async {
                  await _onRefresh(context);
                },
                child: PostsListWidget(posts: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.errorMsg);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                const PostsAddUpdateScreen(isUpdateScreen: false),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
