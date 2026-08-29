import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/constants/app_colors.dart';

class CustomContainerColor extends StatelessWidget {
  const CustomContainerColor({
    super.key,
    required this.text,
    this.colors,
    this.isSelected = false,
    this.onTap,
  });

  final String text;
  final List<Color>? colors;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final gradientColors = colors ?? const [Color(0xFF225924), Color(0xFFE1DFDF)];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrange.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : AppColors.borderColor,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14.w,
              height: 14.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: gradientColors,
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primaryOrange : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Backwards-compatibility class alias for Customcontainercolor
typedef Customcontainercolor = CustomContainerColor;
