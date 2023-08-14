import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/ui.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.validator

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7)
    );

    return TextFormField(
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
        // hintText: hintText,
        border: inputBorder,
        labelText: hintText,

        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}

showSnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

class GapWidget extends StatelessWidget {
  final double size;
  const GapWidget({super.key, this.size = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16 + size,
      height: 16 + size,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        onPressed: onPressed,
        color: color ?? AppColors.accent,
        child: Text(text),
      ),
    );
  }
}

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String)? onChanged;

  const PrimaryTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.initialValue,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7)
          ),
          labelText: labelText
      ),
    );
  }
}