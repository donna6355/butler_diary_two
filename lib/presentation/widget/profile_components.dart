import 'package:flutter/material.dart';
import '../../core/core.dart';

class Character extends StatelessWidget {
  const Character({required this.photo, super.key});
  final String photo;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
          width: 120,
          height: 120,
          child: Image.asset('assets/img/${photo}1.png'),
        ),
      ),
    );
  }
}

enum CatType {
  basic(Lang.basic),
  elegant(Lang.elegant),
  dynamic(Lang.dynamic),
  sleepy(Lang.sleepy),
  weird(Lang.weird);

  final String label;
  const CatType(this.label);
}

class TypeButton extends StatelessWidget {
  const TypeButton({
    required this.type,
    required this.val,
    required this.onTap,
    super.key,
  });
  final CatType type;
  final String val;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: type.name == val ? CommonStyle.primaryGray : null,
      ),
      child: Center(
        child: TextButton(
          style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () => onTap(type.name),
          child: Text(
            type.label,
            style:
                type.name == val ? const TextStyle(color: Colors.white) : null,
          ),
        ),
      ),
    );
  }
}

class ProfileLabel extends StatelessWidget {
  const ProfileLabel(this.label, {this.required = false, super.key});
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Text('${required ? Lang.required : ''}$label',
          style: CommonStyle.labelFont),
    );
  }
}

class ProfileLabelVal extends StatelessWidget {
  const ProfileLabelVal({required this.label, required this.value, super.key});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileLabel(label, required: false),
          Text(value, style: CommonStyle.labelFont),
        ],
      ),
    );
  }
}

class RadioBtn extends StatelessWidget {
  const RadioBtn({
    required this.groupVal,
    required this.val,
    required this.onChanged,
    super.key,
  });
  final int val;
  final int groupVal;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.7,
          child: Radio<int>(
            activeColor: CommonStyle.primaryGray,
            value: val,
            groupValue: groupVal,
            onChanged: onChanged,
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(val),
          child: Text(val == 1 ? Lang.male : Lang.female),
        ),
      ],
    );
  }
}
