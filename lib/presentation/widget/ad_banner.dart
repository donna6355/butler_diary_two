import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/core.dart';

class AdBanner extends StatelessWidget {
  AdBanner({super.key});
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-5356942048071979/5909864936',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          Img.adBg,
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
        ),
        FutureBuilder(
          future: myBanner.load(),
          builder: (_, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const SizedBox.shrink()
                : SizedBox(
                    width: myBanner.size.width.toDouble(),
                    height: myBanner.size.height.toDouble(),
                    child: AdWidget(ad: myBanner),
                  );
          },
        ),
      ],
    );
  }
}
