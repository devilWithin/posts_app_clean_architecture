import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLine;
  final String name;
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.multiLine,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? "$name can't be null" : null,
        decoration: InputDecoration(hintText: name),
        minLines: multiLine ? 6 : 1,
        maxLines: multiLine ? 6 : 1,
      ),
    );
  }
}
