import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widget/widget.dart';
import '../../core/core.dart';
import '../../data/model/profile.dart';

class LivingRoom extends StatelessWidget {
  const LivingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ProfileDrawer(),
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
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box>(
                valueListenable: Hive.box(Constants.profile).listenable(),
                builder: (context, box, widget) {
                  if (box.length == 0) return const BeMyButler();
                  return Stack(
                    children: [
                      const Background(),
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: box.length,
                          itemBuilder: (BuildContext ctx, idx) {
                            final Profile profile = box.getAt(idx);
                            return CatCards(
                              profile: profile,
                              vertical: box.length < 2 ? true : false,
                            );
                          }),
                    ],
                  );
                }),
          ),
          //TODO add google ad
          // FutureBuilder(
          //   future: myBanner.load(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return CircularProgressIndicator();
          //     }
          //     final AdWidget adWidget = AdWidget(ad: myBanner);
          //     final Container adContainer = Container(
          //       alignment: Alignment.center,
          //       child: adWidget,
          //       width: myBanner.size.width.toDouble(),
          //       height: myBanner.size.height.toDouble(),
          //       decoration: BoxDecoration(
          //         image: DecorationImage(
          //           image: AssetImage("assets/img/darkad.png"),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     );
          //     return adContainer;
          //   },
          // ),
        ],
      ),
    );
  }
}
