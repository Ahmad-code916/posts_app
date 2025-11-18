import 'package:flutter/material.dart';

class FlloatingActionButton extends StatelessWidget {
  const FlloatingActionButton({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        height: 50,
        width: 50,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
