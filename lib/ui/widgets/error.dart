import 'package:flutter/material.dart';
import 'package:nike_2/common/exception.dart';

class AppExceptionWidget extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onPressed;
  const AppExceptionWidget({
    super.key,
    required this.exception,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.message),
          ElevatedButton(onPressed: onPressed, child: Text('تلاش دوباره')),
        ],
      ),
    );
  }
}
