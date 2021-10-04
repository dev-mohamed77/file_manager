import 'package:flutter/material.dart';

class SectionText extends StatelessWidget {
  const SectionText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
