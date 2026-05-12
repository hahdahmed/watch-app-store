import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/widgets/customcontainercolor.dart';

class Detailedprodect extends StatefulWidget {
  const Detailedprodect({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  final String image;
  final String title;
  final String price;

  @override
  State<Detailedprodect> createState() => _DetailedprodectState();
}

class _DetailedprodectState extends State<Detailedprodect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 35,
                icon: Icon(Icons.arrow_back_rounded),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 35,
                icon: Icon(Icons.favorite_border_outlined),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  width: double.infinity,
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 100),

                        child: Text(
                          widget.title,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      Row(
                        children: [
                          Padding(padding: const EdgeInsets.only(left: 50)),
                          // SizedBox(width: 15.w),
                          Text(
                            "(With Solo Loop)",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),

                          SizedBox(width: 120.w),
                          Text(
                            "\$${widget.price}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF24E1E),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      Padding(
                        padding: const EdgeInsets.only(right: 240),
                        child: Text(
                          "Colors",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SizedBox(width: 10.w),

                          Customcontainercolor(
                            text: "Green/grey",
                            colors: [Color(0xff225924), Color(0xffE1DFDF)],
                          ),
                          SizedBox(width: 10.w),
                          Customcontainercolor(
                            text: "Green/grey",
                            colors: [Color(0xff0904E7), Color(0xff0B0A0A)],
                          ),

                          SizedBox(width: 10.w),
                          Customcontainercolor(
                            text: "Green/grey",
                            colors: [Color(0xff7B7A9D), Color(0xff7B7A9D)],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 240),
                        child: Text(
                          "Details ",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffF24E1E),
                            ),
                          ),
                        ),
                      ),

                      Text(
                        "Apple Watch Ultra 2 integrates L1 and L5 GPS into an\nantenna d esign that provides greater range with\nincredible power efficiency. It combines data from both ... ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 11,

                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 248,
                        height: 49,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF24E1E),
                        ),
                        child: Center(
                          child: Text(
                            "Add to cart",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Image.asset(widget.image, width: 300.h),
          ),

          ColoredContainer(),
        ],
      ),
    );
  }
}

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10.h),
        Container(
          width: 15.w,
          height: 15.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 15.w,
          height: 15.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepOrangeAccent,
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 15.w,
          height: 15.h,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        ),
      ],
    );
  }
}
