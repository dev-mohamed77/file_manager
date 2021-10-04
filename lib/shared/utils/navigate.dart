import 'package:flutter/material.dart';

class Navigate {
  static void push({
    required BuildContext ctx,
    required Widget screen,
  }) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (ctx) => screen),
    );
  }

  static void pushReplace({
    required BuildContext ctx,
    required Widget screen,
  }) {
    Navigator.of(ctx)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => screen));
  }
}
