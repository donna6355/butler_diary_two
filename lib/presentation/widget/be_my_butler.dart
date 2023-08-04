import 'package:flutter/material.dart';

import '../../core/core.dart';

class BeMyButler extends StatelessWidget {
  const BeMyButler({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 70, 50, 20),
            child: Image.asset(Img.pickMe),
          ),
          const Text(Lang.beMyButler, style: TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(NamedRoutes.profileEdit),
            child: const Text(Lang.writeProfile),
          ),
        ],
      ),
    );
  }
}
