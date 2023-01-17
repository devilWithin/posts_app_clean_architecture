import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';

import '../../../domain/entities/post.dart';
import 'custom_text_form_field.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdateScreen;
  final Post? post;
  const FormWidget({Key? key, required this.isUpdateScreen, this.post})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateScreen) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void validateFormThenUpdateOrAddPost() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
        id: widget.isUpdateScreen ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.isUpdateScreen) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(
          UpdatePostEvent(post: post),
        );
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(
          AddPostEvent(post: post),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
              name: "Title", controller: _titleController, multiLine: false),
          CustomTextFormField(
              name: "Body", controller: _bodyController, multiLine: true),
          ElevatedButton.icon(
              onPressed: () {
                validateFormThenUpdateOrAddPost();
              },
              icon: Icon(widget.isUpdateScreen ? Icons.edit : Icons.add),
              label: Text(widget.isUpdateScreen ? 'Update' : 'Add'))
        ],
      ),
    );
  }
}
