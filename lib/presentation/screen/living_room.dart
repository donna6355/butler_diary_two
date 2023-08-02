import 'package:flutter/material.dart';
import '../../core/core.dart';

class LivingRoom extends StatelessWidget {
  const LivingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0,
        title: const Text(Lang.butlerDiary),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(NamedRoutes.profileEdit),
            child: const Text(Lang.obtainCat),
          ),
        ],
      ),
      body: Text('LIVING ROOM'),
    );
  }
}
