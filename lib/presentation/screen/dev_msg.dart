import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../../logic/logic.dart';

class DevMsg extends StatelessWidget {
  const DevMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(Lang.devMsg),
        actions: [
          TextButton(
            onPressed: () => sendEmail(context),
            child: const Text(Lang.sendMsg),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 150),
            child: const Text(
              Lang.thanks,
              style: TextStyle(fontSize: 18, height: 2),
            ),
          ),
          Positioned(
            width: 250,
            height: 250,
            right: 0,
            bottom: -30,
            child: Image.asset(Img.devMsg),
          ),
        ],
      ),
    );
  }
}
