import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../data/model/profile.dart';
import '../../data/hive_storage.dart';
import '../widget/drawer_components.dart';
import '../widget/profile_components.dart';

class ProfileScr extends StatefulWidget {
  const ProfileScr({super.key});

  @override
  State<ProfileScr> createState() => _ProfileScrState();
}

class _ProfileScrState extends State<ProfileScr> {
  final _weightCont = TextEditingController();
  final _remarksCont = TextEditingController();
  Profile? cat;
  String _photo = 'basic';
  bool _dirty = false;

  void _updateInfo(Profile master) {
    if (cat != null) return;
    setState(() {
      cat = master;
      _photo = master.photo!;
      if (master.remark!.isNotEmpty) _remarksCont.text = master.remark ?? '';
      if (master.weight != null) _weightCont.text = '${master.weight}';
    });
  }

  void _typeUpdate(String type) {
    setState(() {
      _dirty = true;
      _photo = type;
    });
  }

  void _getDirty() {
    setState(() {
      _dirty = true;
    });
  }

  Future<void> _saveProfile() async {
    if (!_dirty) return;
    final Profile newCat = Profile(
        id: cat!.id,
        name: cat!.name,
        birth: cat!.birth,
        gender: cat!.gender,
        photo: _photo,
        weight:
            _weightCont.text.isEmpty ? null : double.parse(_weightCont.text),
        remark: _remarksCont.text.isEmpty ? '' : _remarksCont.text);
    await HiveStore.saveCatProfile(newCat.id, newCat);

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _removeProfile() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlert(cat!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Profile master =
        ModalRoute.of(context)!.settings.arguments as Profile;
    _updateInfo(master);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Lang.profile),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(
                  NamedRoutes.diary,
                  arguments: master,
                );
              },
              child: const Text(Lang.diary)),
        ],
      ),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Photo(photo: _photo),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: CatType.values
                    .map((val) => TypeButton(
                          val: _photo,
                          type: val,
                          onTap: _typeUpdate,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              ProfileLabelVal(label: Lang.name, value: master.name),
              ProfileLabelVal(
                  label: Lang.gender,
                  value: master.gender == 1 ? Lang.male : Lang.female),
              ProfileLabelVal(label: Lang.birth, value: master.birth.calc()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileLabel(Lang.weight),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      onChanged: (_) => _getDirty(),
                      cursorColor: CommonStyle.primaryGray,
                      controller: _weightCont,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: CommonStyle.underlineInput(Lang.weightEx),
                    ),
                  ),
                  const Text(Lang.kg, style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 10),
              const ProfileLabel(Lang.remark),
              TextField(
                onChanged: (_) => _getDirty(),
                cursorColor: CommonStyle.primaryGray,
                controller: _remarksCont,
                maxLines: 2,
                maxLength: 100,
                decoration: CommonStyle.underlineInput(Lang.remarkEx),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _removeProfile,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(CommonStyle.secondGray),
                    ),
                    child: const Text(Lang.delete),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveProfile,
                      style: ButtonStyle(
                        backgroundColor: _dirty
                            ? null
                            : MaterialStateProperty.all(CommonStyle.secondGray),
                      ),
                      child: const Text(Lang.save),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
