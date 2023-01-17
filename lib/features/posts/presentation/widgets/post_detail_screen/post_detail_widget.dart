import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/custom_snack_bar.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_add_update_screen.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';

import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50,
            thickness: 2,
          ),
          Text(
            post.body,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(
            height: 50,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostsAddUpdateScreen(
                        isUpdateScreen: true,
                        post: post,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  deleteDialog(context);
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
              listener: (context, state) {
                if (state is SuccessAddDeleteUpdatePostState) {
                  CustomSnackBar().showSuccessSnackBar(
                      message: state.successMessage, context: context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const PostsScreen(),
                      ),
                      (route) => false);
                } else if (state is ErrorAddDeleteUpdatePostState) {
                  CustomSnackBar().showErrorSnackBar(
                      message: state.errorMessage, context: context);
                }
              },
              builder: (context, state) {
                return Container();
              },
            ));
  }
}
