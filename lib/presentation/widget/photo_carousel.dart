import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/core.dart';

class PhotoCarousel extends StatelessWidget {
  const PhotoCarousel({required this.photos, required this.idx, super.key});
  final int idx;
  final List<dynamic> photos;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 0.62),
      children: [
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: idx,
            ),
            items: photos.map(
              (path) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.file(
                      File(path),
                      fit: BoxFit.cover,
                      width: 400,
                      height: 400,
                    );
                  },
                );
              },
            ).toList(),
          ),
        ),
        Image.asset(Img.swipe, width: 250),
      ],
    );
  }
}
