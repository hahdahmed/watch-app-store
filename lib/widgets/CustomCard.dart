import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Customcard extends StatefulWidget {
  const Customcard({
    super.key,
    required this.image,
    required this.title,
    required this.brand,
    required this.price,
  });

  final String image;
  final String title;
  final String brand;
  final String price;

  @override
  State<Customcard> createState() => _CustomcardState();
}

class _CustomcardState extends State<Customcard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      width: 147.w,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.image,
                  height: 50.h,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
              // SizedBox(height: 2.h),
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                widget.brand,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.price,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xffF24E1E),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
