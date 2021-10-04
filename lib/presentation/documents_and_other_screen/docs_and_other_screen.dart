import 'package:exfile/presentation/documents_and_other_screen/widget/docs_and_other_body.dart';
import 'package:flutter/material.dart';

class DocsAndOtherScreen extends StatelessWidget {
  const DocsAndOtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Documents"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const DocsAndOtherBody(),
    );
  }
}
