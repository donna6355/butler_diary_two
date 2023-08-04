import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../data/model/profile.dart';
import '../../data/hive_storage.dart';
import '../widget/profile_components.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _nameCont = TextEditingController();
  final _remarksCont = TextEditingController();
  final _weightCont = TextEditingController();
  DateTime? _birth;
  int _gender = -1;
  String _photo = CatType.basic.name;

  void _genderUpdate(int? val) {
    FocusScope.of(context).unfocus();
    if (val == null) return;
    setState(() {
      _gender = val;
    });
  }

  void _typeUpdate(String type) {
    setState(() {
      _photo = type;
    });
  }

  void _showCalendar() {
    FocusScope.of(context).unfocus();
    showDatePicker(
        context: context,
        helpText: Lang.pickBirth,
        cancelText: Lang.cancel,
        confirmText: Lang.confirm,
        initialDate: _birth ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year,
        builder: (_, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(primary: CommonStyle.primaryGray),
            ),
            child: child!,
          );
        }).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _birth = pickedDate;
      });
    });
  }

  Future<void> _saveProfile() async {
    //TODO separate logic
    if (_nameCont.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(Lang.nameAlert)));
      return;
    }
    if (!HiveStore.checkMasterName(_nameCont.text.trim())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(Lang.dupNameAlert)));
      return;
    }
    if (_gender == -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(Lang.genderAlert)));
      return;
    }
    if (_birth == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(Lang.birthAlert)));
      return;
    }
    final Profile newCat = Profile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameCont.text,
        birth: _birth!,
        gender: _gender,
        photo: _photo,
        weight:
            _weightCont.text.isEmpty ? null : double.parse(_weightCont.text),
        remark: _remarksCont.text.isEmpty ? '' : _remarksCont.text);
    await HiveStore.saveCatProfile(newCat.id, newCat);

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Lang.newProfile),
        elevation: 0,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileLabel(Lang.name, required: true),
                  Expanded(
                    child: TextField(
                      cursorColor: CommonStyle.primaryGray,
                      controller: _nameCont,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      decoration: CommonStyle.underlineInput(Lang.nameEx),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileLabel(Lang.gender, required: true),
                  RadioBtn(
                    groupVal: _gender,
                    val: 1,
                    onChanged: _genderUpdate,
                  ),
                  const SizedBox(width: 15),
                  RadioBtn(
                    groupVal: _gender,
                    val: 2,
                    onChanged: _genderUpdate,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileLabel(Lang.birth, required: true),
                  Text(_birth == null ? Lang.birthEx : _birth!.calc()),
                  IconButton(
                    onPressed: _showCalendar,
                    icon: const Icon(Icons.calendar_today_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileLabel(Lang.weight),
                  SizedBox(
                    width: 80,
                    child: TextField(
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
                cursorColor: CommonStyle.primaryGray,
                controller: _remarksCont,
                maxLines: 2,
                maxLength: 100,
                decoration: CommonStyle.underlineInput(Lang.remarkEx),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                Lang.fillRequired,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text(Lang.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
