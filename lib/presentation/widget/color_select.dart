import 'package:flutter/material.dart';

class ColorSelect extends StatelessWidget {
  final Function(double) onSelect;
  final double isSelected;
  const ColorSelect(this.onSelect, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ColorBtn(0, Color(0xff585858), isSelected, (val) => onSelect(val)),
          ColorBtn(1, Color(0xffFF6961), isSelected, (val) => onSelect(val)),
          ColorBtn(2, Color(0xffFFB347), isSelected, (val) => onSelect(val)),
          ColorBtn(3, Color(0xff77DD77), isSelected, (val) => onSelect(val)),
        ],
      ),
    );
  }
}

class ColorBtn extends StatelessWidget {
  final double value;
  final Color color;
  final double isSelected;
  final Function(double) onSelect;
  const ColorBtn(this.value, this.color, this.isSelected, this.onSelect,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(value),
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: SizedBox(width: 54, height: 54),
          ),
          if (isSelected == value)
            Icon(
              Icons.check,
              color: Colors.white,
              size: 30,
              fontWeight: FontWeight.w900,
            )
        ],
      ),
    );
  }
}
