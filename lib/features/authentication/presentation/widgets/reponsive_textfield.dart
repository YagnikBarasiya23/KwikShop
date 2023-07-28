import 'package:flutter/material.dart';

class ReusedTextField extends StatelessWidget {
  const ReusedTextField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.validator,
    this.isVisible = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIcon = const SizedBox(),
    this.keyboardType = TextInputType.name,
    required this.controller,
  });
  final String labelText;
  final IconData prefixIcon;
  final Widget suffixIcon;
  final bool isVisible;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      obscureText: isVisible,
      style: TextStyle(
        color: colorScheme.onSurface,
      ),
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
