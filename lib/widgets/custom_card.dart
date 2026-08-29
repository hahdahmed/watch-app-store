import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/constants/app_colors.dart';
import 'package:watch_app/models/watchcardmodel.dart';
import 'package:watch_app/providers/watch_provider.dart';

class CustomCard extends StatelessWidget {
  final WatchCardModel watch;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.watch,
    this.onTap,
  });

  Widget _buildImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: 75.h,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(Icons.watch_outlined, size: 50.w, color: Colors.grey),
      );
    }
    return Image.network(
      path,
      height: 75.h,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: 50.w, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WatchProvider>();
    final isFav = provider.isFavorite(watch.id);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: Colors.amber, size: 14.sp),
                    SizedBox(width: 2.w),
                    Text(
                      watch.rating > 0 ? watch.rating.toStringAsFixed(1) : "4.8",
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => provider.toggleFavorite(watch.id),
                  child: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: isFav ? AppColors.primaryOrange : Colors.grey[400],
                    size: 18.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Center(
              child: _buildImage(watch.thumbnail),
            ),
            SizedBox(height: 8.h),
            Text(
              watch.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              watch.brand,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.normal,
                fontSize: 11.sp,
                color: AppColors.greyText,
              ),
            ),
            const Spacer(),
            Text(
              "\$${watch.price.toStringAsFixed(2)}",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
                color: AppColors.primaryOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Backwards-compatibility class alias for Customcard
typedef Customcard = CustomCard;
