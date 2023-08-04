import 'package:flutter/material.dart';
import 'dart:math';

import '../../core/core.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 25,
      bottom: 10,
      child: Opacity(
        opacity: 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 140,
              height: 140,
              margin: const EdgeInsets.only(bottom: 10),
              child: Image.asset('assets/img/face${Random().nextInt(8)}.png'),
            ),
            Text(commonSense[Random().nextInt(commonSense.length)]),
          ],
        ),
      ),
    );
  }
}
