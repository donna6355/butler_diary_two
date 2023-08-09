import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widget/widget.dart';
import '../../core/core.dart';
import '../../data/model/diary.dart';

class DiaryEdit extends StatefulWidget {
  const DiaryEdit({super.key});

  @override
  State<DiaryEdit> createState() => _DiaryEditState();
}

class _DiaryEditState extends State<DiaryEdit> {
  final noteCtrl = TextEditingController();
  String date = '';
  double feel = -1;
  double dryFood = -1;
  double wetFood = -1;
  double water = -1;
  bool waterySnack = false;
  bool drySnack = false;
  bool snack = false;
  bool otherSnack = false;
  double pee = -1;
  double poo = -1;
  bool hairBall = false;
  bool diarrhea = false;
  bool vomit = false;
  bool destroy = false;
  bool vet = false;
  bool vaccine = false;
  bool pill = false;
  bool eyeDrop = false;
  bool hunting = false;
  bool brushTeeth = false;
  bool brushFur = false;
  bool clawCut = false;
  bool bath = false;
  bool toilet = false;
  String note = '';
  List<dynamic> photos = [];
  late Box diaryBox;
  bool dirty = false;

  void _updateInfo(Map<String, dynamic> master) {
    if (date.isNotEmpty) return;
    setState(() => date = master['date']);

    diaryBox = Hive.box('diary_${master['key']}');
    final Diary? dailyData = diaryBox.get(master['date']);
    if (dailyData == null) {
      return;
    } else {
      setState(() {
        feel = dailyData.feel;
        dryFood = dailyData.dryFood;
        wetFood = dailyData.wetFood;
        water = dailyData.water;
        waterySnack = dailyData.waterySnack;
        drySnack = dailyData.drySnack;
        otherSnack = dailyData.otherSnack;
        snack = dailyData.snack;
        pee = dailyData.pee;
        poo = dailyData.poo;
        hairBall = dailyData.hairBall;
        diarrhea = dailyData.diarrhea;
        vomit = dailyData.vomit;
        destroy = dailyData.destroy;
        vet = dailyData.vet;
        vaccine = dailyData.vaccine;
        pill = dailyData.pill;
        eyeDrop = dailyData.eyeDrop;
        hunting = dailyData.hunting;
        brushTeeth = dailyData.brushTeeth;
        brushFur = dailyData.brushFur;
        clawCut = dailyData.clawCut;
        bath = dailyData.bath;
        toilet = dailyData.toilet;
        note = dailyData.note;
        noteCtrl.text = dailyData.note.isNotEmpty ? dailyData.note : '';
        if (dailyData.photos.isNotEmpty) {
          photos = dailyData.photos;
        }
      });
    }
  }

  void _togglesetState(String name) {
    setState(() {
      dirty = true;
      switch (name) {
        case Lang.paste:
          waterySnack = !waterySnack;
          break;
        case Lang.treat:
          drySnack = !drySnack;
          break;
        case Lang.can:
          snack = !snack;
          break;
        case Lang.etc:
          otherSnack = !otherSnack;
          break;
        case Lang.hairBall:
          hairBall = !hairBall;
          break;
        case Lang.diarrhea:
          diarrhea = !diarrhea;
          break;
        case Lang.puke:
          vomit = !vomit;
          break;
        case Lang.destroy:
          destroy = !destroy;
          break;
        case Lang.vet:
          vet = !vet;
          break;
        case Lang.vaccine:
          vaccine = !vaccine;
          break;
        case Lang.pill:
          pill = !pill;
          break;
        case Lang.eyedrop:
          eyeDrop = !eyeDrop;
          break;
        case Lang.hunt:
          hunting = !hunting;
          break;
        case Lang.tooth:
          brushTeeth = !brushTeeth;
          break;
        case Lang.brush:
          brushFur = !brushFur;
          break;
        case Lang.bath:
          bath = !bath;
          break;
        case Lang.claw:
          clawCut = !clawCut;
          break;
        case Lang.clean:
          toilet = !toilet;
          break;
        default:
          note = noteCtrl.text;
          break;
      }
    });
  }

  void _doubleSetState(String name, double value) {
    dirty = true;
    setState(() {
      switch (name) {
        case Lang.indifferent:
          feel = value;
          break;
        case Lang.wetN:
          wetFood = value;
          break;
        case Lang.dryN:
          dryFood = value;
          break;
        case Lang.waterN:
          water = value;
          break;
        case Lang.pooN:
          poo = value;
          break;
        case Lang.peeN:
          pee = value;
          break;
        default:
          break;
      }
    });
  }

  void _addPhoto(String path) {
    setState(() {
      dirty = true;
      photos.add(path);
    });
  }

  void _removePhoto(path) {
    setState(() {
      dirty = true;
      photos.removeWhere((el) => el == path);
    });
  }

  void _saveDiary() async {
    if (!dirty) return;
    if (feel == -1 &&
        dryFood == -1 &&
        wetFood == -1 &&
        water == -1 &&
        waterySnack == false &&
        drySnack == false &&
        snack == false &&
        otherSnack == false &&
        pee == -1 &&
        poo == -1 &&
        hairBall == false &&
        diarrhea == false &&
        vomit == false &&
        destroy == false &&
        vet == false &&
        vaccine == false &&
        pill == false &&
        eyeDrop == false &&
        hunting == false &&
        brushTeeth == false &&
        brushFur == false &&
        clawCut == false &&
        bath == false &&
        toilet == false &&
        note == '' &&
        photos.isEmpty) {
      diaryBox.delete(date);
      Navigator.of(context).pop();
      return;
    }
    final Diary newDiary = Diary(
      date: date,
      feel: feel,
      dryFood: dryFood,
      wetFood: wetFood,
      water: water,
      waterySnack: waterySnack,
      drySnack: drySnack,
      otherSnack: otherSnack,
      snack: snack,
      pee: pee,
      poo: poo,
      hairBall: hairBall,
      diarrhea: diarrhea,
      vomit: vomit,
      destroy: destroy,
      vet: vet,
      vaccine: vaccine,
      pill: pill,
      eyeDrop: eyeDrop,
      hunting: hunting,
      brushTeeth: brushTeeth,
      brushFur: brushFur,
      clawCut: clawCut,
      bath: bath,
      toilet: toilet,
      note: noteCtrl.text,
      photos: photos,
    );
    await diaryBox.put(date, newDiary);

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> info =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _updateInfo(info);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${date.isEmpty ? '' : date.intoYmd()} ${info['master']} ${Lang.diary}'),
        elevation: 0,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _saveDiary,
        style: ButtonStyle(
          backgroundColor:
              dirty ? null : MaterialStateProperty.all(CommonStyle.secondGray),
        ),
        child: const Text(Lang.save),
      ),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const DiaryLabel(Lang.condition),
              MultipleChoice(
                choice1: Lang.indifferent,
                choice2: Lang.bad,
                choice3: Lang.soso,
                choice4: Lang.good,
                choiceVal: feel,
                valueState: _doubleSetState,
              ),
              const SizedBox(height: 30),
              const DiaryLabel(Lang.food),
              MultipleChoice(
                choice1: Lang.wetN,
                choice2: Lang.wetS,
                choice3: Lang.wetM,
                choice4: Lang.wetL,
                choiceVal: wetFood,
                valueState: _doubleSetState,
              ),
              MultipleChoice(
                choice1: Lang.dryN,
                choice2: Lang.dryS,
                choice3: Lang.dryM,
                choice4: Lang.dryL,
                choiceVal: dryFood,
                valueState: _doubleSetState,
              ),
              const SizedBox(height: 30),
              const DiaryLabel(Lang.water),
              MultipleChoice(
                choice1: Lang.waterN,
                choice2: Lang.waterS,
                choice3: Lang.waterM,
                choice4: Lang.waterL,
                choiceVal: water,
                valueState: _doubleSetState,
              ),
              const SizedBox(height: 30),
              const DiaryLabel(Lang.snack),
              ToggleChoiceRow(
                label1: Lang.paste,
                label2: Lang.treat,
                label3: Lang.can,
                label4: Lang.etc,
                choiceVal1: waterySnack,
                choiceVal2: drySnack,
                choiceVal3: snack,
                choiceVal4: otherSnack,
                toggleState: _togglesetState,
              ),
              const DiaryLabel(Lang.poo),
              MultipleChoice(
                choice1: Lang.pooN,
                choice2: Lang.pooS,
                choice3: Lang.pooM,
                choice4: Lang.pooL,
                choiceVal: poo,
                valueState: _doubleSetState,
              ),
              const SizedBox(height: 30),
              const DiaryLabel(Lang.pee),
              MultipleChoice(
                choice1: Lang.peeN,
                choice2: Lang.peeS,
                choice3: Lang.peeM,
                choice4: Lang.peeL,
                choiceVal: pee,
                valueState: _doubleSetState,
              ),
              const SizedBox(height: 30),
              const DiaryLabel(Lang.caution),
              ToggleChoiceRow(
                label1: Lang.hairBall,
                label2: Lang.diarrhea,
                label3: Lang.puke,
                label4: Lang.destroy,
                choiceVal1: hairBall,
                choiceVal2: diarrhea,
                choiceVal3: vomit,
                choiceVal4: destroy,
                toggleState: _togglesetState,
              ),
              const DiaryLabel(Lang.sick),
              ToggleChoiceRow(
                label1: Lang.vet,
                label2: Lang.vaccine,
                label3: Lang.pill,
                label4: Lang.eyedrop,
                choiceVal1: vet,
                choiceVal2: vaccine,
                choiceVal3: pill,
                choiceVal4: eyeDrop,
                toggleState: _togglesetState,
              ),
              const DiaryLabel(Lang.beauty),
              ToggleChoiceRow(
                label1: Lang.tooth,
                label2: Lang.brush,
                label3: Lang.bath,
                label4: Lang.claw,
                choiceVal1: brushTeeth,
                choiceVal2: brushFur,
                choiceVal3: bath,
                choiceVal4: clawCut,
                toggleState: _togglesetState,
                marginS: true,
              ),
              ToggleChoiceRow(
                label1: Lang.hunt,
                label2: Lang.clean,
                choiceVal1: hunting,
                choiceVal2: toilet,
                toggleState: _togglesetState,
              ),
              const DiaryLabel(Lang.comment),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 30),
                child: TextField(
                  cursorColor: CommonStyle.primaryGray,
                  onChanged: _togglesetState,
                  controller: noteCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: Lang.commentHint,
                    border: InputBorder.none,
                  ),
                ),
              ),
              DiaryLabel(
                  '${Lang.proof} ${photos.isNotEmpty ? "(${photos.length})" : ""}'),
              InputPhoto(_addPhoto),
              PhotoPreviews(photos: photos, removePic: _removePhoto),
            ],
          ),
        ),
      ),
    );
  }
}
