import 'package:cekgizi_mobile/tema.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  final double w, h;
  final String nama;
  final VoidCallback fungsi;

  const Button({
    super.key,
    required this.w,
    required this.h,
    required this.nama,
    required this.fungsi,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fungsi,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: warnaHitam, // Pindahkan warna ke sini!
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: Text(
            nama,
            style: putihStyle.copyWith(fontSize: 13, fontWeight: bold),
          ),
        ),
      ),
    );
  }
}
