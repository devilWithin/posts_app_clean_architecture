import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/custom_snack_bar.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';

import '../../domain/entities/post.dart';
import '../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../widgets/posts_add_update_screen_widgets/form_widget.dart';

class PostsAddUpdateScreen extends StatelessWidget {
  final Post? post;
  final bool isUpdateScreen;
  const PostsAddUpdateScreen({
    Key? key,
    this.post,
    required this.isUpdateScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdateScreen ? 'Update post' : 'Add post'));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is ErrorAddDeleteUpdatePostState) {
              CustomSnackBar().showErrorSnackBar(
                  message: state.errorMessage, context: context);
            } else if (state is SuccessAddDeleteUpdatePostState) {
              CustomSnackBar().showSuccessSnackBar(
                  message: state.successMessage, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const PostsScreen()),
                  (route) => false);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const LoadingWidget();
            }

            return FormWidget(
                isUpdateScreen: isUpdateScreen,
                post: isUpdateScreen ? post : null);
          },
        ),
      ),
    );
  }
}
