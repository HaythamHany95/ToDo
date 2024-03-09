import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final Widget? suffixIcon;
  final bool obscureText;

  const AuthTextFormField(
      {this.controller,
      this.validator,
      this.labelText,
      this.suffixIcon,
      this.obscureText = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
              errorMaxLines: 3,
              suffixIcon: suffixIcon,
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: MyTheme.petrolColor, fontSize: 14),
              labelText: labelText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyTheme.primaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyTheme.primaryColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyTheme.redColor, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyTheme.redColor, width: 2),
              ))),
    );
  }
}
