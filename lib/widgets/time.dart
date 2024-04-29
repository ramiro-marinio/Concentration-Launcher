import 'package:flutter/material.dart';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({super.key});

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Center(
        child: StreamBuilder(
          stream:
              Stream.periodic(const Duration(seconds: 1), (computationCount) {
            return DateTime.now();
          }),
          builder: (context, snapshot) {
            final date = DateTime.now();
            return Text(
              '${formatNumber(date.hour)}:${formatNumber(date.minute)}:${formatNumber(date.second)}',
              style: const TextStyle(fontSize: 50),
            );
          },
        ),
      ),
    );
  }
}

String formatNumber(int number) {
  if (number >= 10) {
    return number.toString();
  } else {
    return '0$number';
  }
}
