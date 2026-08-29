import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/constants/app_colors.dart';
import 'package:watch_app/models/watchcardmodel.dart';
import 'package:watch_app/providers/watch_provider.dart';
import 'package:watch_app/widgets/custom_container_color.dart';

class DetailedProductPage extends StatefulWidget {
  const DetailedProductPage({super.key, required this.watch});

  final WatchCardModel watch;

  @override
  State<DetailedProductPage> createState() => _DetailedProductPageState();
}

class _DetailedProductPageState extends State<DetailedProductPage> {
  int _selectedColorIndex = 0;

  Widget _buildWatchImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(Icons.watch_outlined, size: 120.w, color: Colors.grey),
      );
    }
    return Image.network(
      path,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: 120.w, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WatchProvider>();
    final isFav = provider.isFavorite(widget.watch.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black87),
        ),
        actions: [
          IconButton(
            onPressed: () => provider.toggleFavorite(widget.watch.id),
            icon: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_border_outlined,
              color: isFav ? AppColors.primaryOrange : Colors.black87,
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(20.w),
                alignment: Alignment.center,
                child: Hero(
                  tag: 'watch_${widget.watch.id}',
                  child: _buildWatchImage(widget.watch.thumbnail),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 15,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                                Text(
                                  widget.watch.brand,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "\$${widget.watch.price.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ],
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
                      Row(
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
                      Center(
                        child: SizedBox(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Backwards-compatibility class alias for Detailedprodect
typedef Detailedprodect = DetailedProductPage;
