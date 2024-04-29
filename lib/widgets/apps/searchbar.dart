import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  final Function(String value) onChanged;
  final String? title;
  const AppSearchBar({super.key, required this.onChanged, this.title});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: widget.title ?? 'Search apps...',
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  controller.clear();
                  widget.onChanged('');
                  setState(() {});
                },
                icon: const Icon(Icons.close),
              )
            : null,
      ),
    );
  }
}
