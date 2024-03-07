import 'package:flutter/material.dart';

class AsyncAwareWidget extends StatelessWidget {
  const AsyncAwareWidget({
    Key? key,
    required this.inAsyncCall,
    this.dismissible = false,
    required this.child,
  }) : super(key: key);

  final bool inAsyncCall;
  final bool dismissible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (dismissible) {
          return true;
        } else {
          return !inAsyncCall;
        }
      },
      child: child,
    );
  }
}
