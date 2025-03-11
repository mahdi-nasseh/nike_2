import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget? callToAction;

  const EmptyScreen(
      {super.key,
      required this.message,
      required this.image,
      this.callToAction});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
        
          Padding(
            padding: const EdgeInsets.fromLTRB(48, 32, 48, 8),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ),
          if (callToAction != null) callToAction!
        ],
      ),
    );
  }
}
