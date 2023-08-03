import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/core.dart';
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
  late Box catBox;

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
              Photo(isPhone: true, photo: _photo),
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
                  const ProfileLabel(Lang.name),
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
                  const ProfileLabel(Lang.gender),
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
                  const ProfileLabel(Lang.birth),
                  GestureDetector(
                    onTap: () {},
                    child: Text(_birth == null ? Lang.birthEx : _birth!.calc()),
                  ),
                  IconButton(
                    onPressed: () {},
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
                onPressed: () {},
                child: const Text(Lang.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
