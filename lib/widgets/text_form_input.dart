import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String labelText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? initialValue;
  final keyboardType;
  final int? maxLines;

  const TextFormInput({
    this.initialValue,
    this.obscureText = false,
    required this.hintText,
    required this.labelText,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.maxLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          inputFormatters: inputFormatters,
          validator: validator,
          keyboardType: keyboardType,
          onChanged: onChanged,
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.red, fontSize: 16),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
