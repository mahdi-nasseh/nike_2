import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final int value;
  const CustomBadge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value > 0,
      child: Container(
        width: 16,
        height: 16,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Text(
          value.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontFamily: 'iranYekan'),
        ),
      ),
    );
  }
}
