import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String name;

  const CategoryChip({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(name),
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    );
  }
}
