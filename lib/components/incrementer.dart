import 'package:flutter/material.dart';

class Incrementer extends StatefulWidget {
  int value;
  String? title;
  Function(int)? parentCallBack;
  Incrementer(
      {super.key, required this.value, this.title, this.parentCallBack});

  @override
  State<Incrementer> createState() => _IncrementerState();
}

class _IncrementerState extends State<Incrementer> {
  void increment(int byHowMuch) {
    int nextValue;
    if (widget.parentCallBack != null) {
      nextValue = widget.parentCallBack!(widget.value + byHowMuch);
    } else {
      nextValue = widget.value + byHowMuch;
    }
    setState(() {
      widget.value = nextValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title == null ? const SizedBox.shrink() : Text(widget.title!),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Color(0xFF8d99ae),
              ),
              onPressed: () {
                increment(-1);
              },
            ),
            Text(
              widget.value.toString(),
              style: const TextStyle(
                color: Color(0xFFedf2f4),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.add_circle_outline,
                color: Color(0xFF8d99ae),
              ),
              onPressed: () {
                increment(1);
              },
            ),
          ],
        ),
      ],
    );
  }
}
