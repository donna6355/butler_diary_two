import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/core.dart';
import 'drawer_components.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                Lang.editProfile,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box>(
                valueListenable: Hive.box(Constants.profile).listenable(),
                builder: (_, box, __) {
                  return box.isEmpty
                      ? const NoCat()
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, idx) => ProfileCard(box.getAt(idx)),
                          itemCount: box.length,
                        );
                },
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(NamedRoutes.devMsg),
                child: const Text(Lang.devMsg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
