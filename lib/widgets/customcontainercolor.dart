import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Customcontainercolor extends StatelessWidget {
  const Customcontainercolor({super.key, required this.text, this.colors});

  final String text;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      height: 20.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xffD9D9D9), width: 1.6.w),
      ),
      child: Row(
        children: [
          SizedBox(width: 4.w),
          Container(
            width: 17.w,
            height: 17.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: colors ?? [Color(0xff225924), Color(0xffE1DFDF)],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
