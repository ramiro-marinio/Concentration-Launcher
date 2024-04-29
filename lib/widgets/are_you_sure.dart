import 'package:flutter/material.dart';

class AreYouSure extends StatelessWidget {
  final VoidCallback yes;
  const AreYouSure({super.key, required this.yes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Are you sure?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            yes();
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
