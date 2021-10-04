import 'package:exfile/presentation/whatsapp_screen/widget/whatsapp_body.dart';
import 'package:flutter/material.dart';

class WhatsAppScreen extends StatelessWidget {
  const WhatsAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("WhatsApp Status"),
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
      body: WhatsAppBody(),
    );
  }
}
