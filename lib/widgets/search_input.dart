import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onSearch;
  final String? hintText;

  const SearchInput({
    required this.onSearch,
    this.hintText,
    super.key,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onSearch,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red, fontSize: 16),
        prefixIcon: Icon(Icons.search),
        hintText: widget.hintText ?? 'Cari produk',
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
    );
  }
}
