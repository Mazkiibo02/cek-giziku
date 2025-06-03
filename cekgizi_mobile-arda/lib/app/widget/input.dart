import 'package:cekgizi_mobile/tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Input extends StatelessWidget {
  double w, h;
  bool cekPassword;
  String icon, labelInput;
  TextEditingController cs;
  Input({
    super.key,
    required this.w,
    required this.h,
    required this.cekPassword,
    required this.icon,
    required this.cs,
    required this.labelInput,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      margin: EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: warnaAbu2,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 21,
            width: 21,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(icon)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: cs,
              style: hitamStyle.copyWith(fontSize: 13, fontWeight: semiBold),
              decoration: InputDecoration(
                hintText: labelInput,
                hintStyle: hitamStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),

                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
