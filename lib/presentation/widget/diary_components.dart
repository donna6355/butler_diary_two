import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../../data/model/diary.dart';
import '../../logic/logic.dart';

class DiaryLabel extends StatelessWidget {
  const DiaryLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: CommonStyle.diaryLabelFont);
  }
}

class DiaryCardLabel extends StatelessWidget {
  const DiaryCardLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(label),
    );
  }
}

class DiaryDivider extends StatelessWidget {
  const DiaryDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.1)),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    required this.dailyData,
    required this.boxKey,
    required this.masterName,
    super.key,
  });
  final Diary dailyData;
  final String boxKey;
  final String masterName;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          NamedRoutes.diaryEdit,
          arguments: {
            'master': masterName,
            'key': boxKey,
            'date': dailyData.date,
          },
        );
      },
      child: const Column(
        children: [
          Icon(Icons.edit),
          Text(Lang.edit, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class InputImg extends StatelessWidget {
  const InputImg(this.updateImg, {super.key});
  final Function(String) updateImg;

  Future<void> _getPic(bool forPic) async {
    String? savedImg = await fetchPhoto(forPic);
    if (savedImg == null) return;
    updateImg(savedImg);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ImgButton(forPic: false, onPressed: _getPic),
        ImgButton(forPic: true, onPressed: _getPic),
      ],
    );
  }
}

class ImgButton extends StatelessWidget {
  const ImgButton({
    required this.forPic,
    required this.onPressed,
    super.key,
  });
  final bool forPic;
  final Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      icon: Icon(forPic ? Icons.photo_camera : Icons.photo_library_outlined),
      onPressed: () => onPressed(forPic),
      label: Text(forPic ? Lang.takePic : Lang.fetchImg),
    );
  }
}

class ImgPreviews extends StatelessWidget {
  const ImgPreviews({
    required this.photos,
    required this.removePic,
    super.key,
  });
  final List<dynamic> photos;
  final Function(String) removePic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var path in photos)
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.file(File(path),
                        fit: BoxFit.cover, width: 200, height: 200),
                  ),
                ),
                GestureDetector(
                  onTap: () => removePic(path),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    width: 26,
                    height: 26,
                    child: const Center(child: Icon(Icons.cancel)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
