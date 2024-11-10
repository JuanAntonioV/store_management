import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final void Function() onPressed;
  final String? text;
  final bool isLoading;
  final Color? backgroundColor;

  const SubmitButton({
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.backgroundColor,
    super.key,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return ElevatedButton.icon(
        onPressed: () {},
        label: Text(''),
        icon: Container(
          width: 24,
          height: 24,
          padding: const EdgeInsets.all(2.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.onPrimary,
            ),
            strokeWidth: 2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
    }

    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(widget.text ?? "Submit",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          )),
    );
  }
}
