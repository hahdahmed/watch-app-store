import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/constants/app_colors.dart';
import 'package:watch_app/models/watchcardmodel.dart';
import 'package:watch_app/providers/watch_provider.dart';
import 'package:watch_app/widgets/custom_container_color.dart';

class ProductDetailsBottomSheet extends StatefulWidget {
  final WatchCardModel watch;

  const ProductDetailsBottomSheet({
    super.key,
    required this.watch,
  });

  static Future<void> show(BuildContext context, WatchCardModel watch) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailsBottomSheet(watch: watch),
    );
  }

  @override
  State<ProductDetailsBottomSheet> createState() => _ProductDetailsBottomSheetState();
}

class _ProductDetailsBottomSheetState extends State<ProductDetailsBottomSheet> {
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.85;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBg,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 15,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            // Top handle indicator
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<WatchProvider>(
                      builder: (context, provider, child) {
                        final isFav = provider.isFavorite(widget.watch.id);
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.watch.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Text(
                                        widget.watch.brand,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.greyText,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        widget.watch.rating > 0
                                            ? widget.watch.rating.toStringAsFixed(1)
                                            : "4.8",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${widget.watch.price.toStringAsFixed(2)}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20.r),
                                    onTap: () => provider.toggleFavorite(widget.watch.id),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.w),
                                      child: Icon(
                                        isFav ? Icons.favorite_rounded : Icons.favorite_border_outlined,
                                        color: isFav ? AppColors.primaryOrange : Colors.black87,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Colors",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomContainerColor(
                            text: "Green/grey",
                            colors: const [Color(0xFF225924), Color(0xFFE1DFDF)],
                            isSelected: _selectedColorIndex == 0,
                            onTap: () => setState(() => _selectedColorIndex = 0),
                          ),
                          SizedBox(width: 8.w),
                          CustomContainerColor(
                            text: "Navy/black",
                            colors: const [Color(0xFF0904E7), Color(0xFF0B0A0A)],
                            isSelected: _selectedColorIndex == 1,
                            onTap: () => setState(() => _selectedColorIndex = 1),
                          ),
                          SizedBox(width: 8.w),
                          CustomContainerColor(
                            text: "Silver/grey",
                            colors: const [Color(0xFF7B7A9D), Color(0xFF7B7A9D)],
                            isSelected: _selectedColorIndex == 2,
                            onTap: () => setState(() => _selectedColorIndex = 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Details",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      widget.watch.description.isNotEmpty
                          ? widget.watch.description
                          : "Premium quality crafted timepiece with durable materials and precision movement.",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<WatchProvider>().addToCart(widget.watch);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${widget.watch.title} added to cart!"),
                              duration: const Duration(seconds: 2),
                              backgroundColor: AppColors.primaryOrange,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          "Add to cart",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
