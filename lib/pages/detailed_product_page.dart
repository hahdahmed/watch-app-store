import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/constants/app_colors.dart';
import 'package:watch_app/models/watchcardmodel.dart';
import 'package:watch_app/providers/watch_provider.dart';
import 'package:watch_app/widgets/product_details_bottom_sheet.dart';

class DetailedProductPage extends StatefulWidget {
  const DetailedProductPage({super.key, required this.watch});

  final WatchCardModel watch;

  @override
  State<DetailedProductPage> createState() => _DetailedProductPageState();
}

class _DetailedProductPageState extends State<DetailedProductPage> {
  Widget _buildWatchImage(String path, {double height = 280}) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: height.h,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(Icons.watch_outlined, size: 120.w, color: Colors.grey),
      );
    }
    return Image.network(
      path,
      height: height.h,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: 120.w, color: Colors.grey),
    );
  }

  void _openDetailsBottomSheet(BuildContext context) {
    ProductDetailsBottomSheet.show(context, widget.watch);
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
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => _openDetailsBottomSheet(context),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'watch_${widget.watch.id}',
                        child: _buildWatchImage(widget.watch.thumbnail, height: 300),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyBg,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                        ),
                        // child: Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     Icon(Icons.touch_app_outlined, size: 18.sp, color: AppColors.primaryOrange),
                        //     SizedBox(width: 8.w),
                        //     Text(
                        //       "Tap image for details",
                        //       style: GoogleFonts.poppins(
                        //         fontSize: 13.sp,
                        //         fontWeight: FontWeight.w600,
                        //         color: Colors.black87,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const _ColoredContainerDots(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _ColoredContainerDots extends StatelessWidget {
  const _ColoredContainerDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          width: 10.w,
          height: 10.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryOrange,
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          width: 10.w,
          height: 10.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

/// Backwards-compatibility class alias for Detailedprodect
typedef Detailedprodect = DetailedProductPage;

