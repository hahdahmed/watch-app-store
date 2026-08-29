import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/constants/app_colors.dart';
import 'package:watch_app/pages/detailed_product_page.dart';
import 'package:watch_app/providers/watch_provider.dart';
import 'package:watch_app/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<WatchProvider>().getWatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WatchProvider>();
    final watches = provider.filteredWatches;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _HomeAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Find your suitable\n watch now.",
                style: GoogleFonts.raleway(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            SizedBox(
              height: 32.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: provider.categories.length,
                separatorBuilder: (_, __) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final isSelected = index == provider.selectedCategoryIndex;
                  return GestureDetector(
                    onTap: () => provider.selectCategory(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.categories[index],
                          style: GoogleFonts.raleway(
                            fontSize: 15.sp,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? AppColors.primaryOrange : AppColors.greyText,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        if (isSelected)
                          Container(
                            width: 30.w,
                            height: 2.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryOrange,
                              borderRadius: BorderRadius.circular(1.r),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primaryOrange))
                  : provider.errorMessage != null && watches.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  provider.errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14.sp, color: Colors.red),
                                ),
                                SizedBox(height: 8.h),
                                ElevatedButton(
                                  onPressed: () => provider.getWatches(),
                                  child: const Text("Retry"),
                                ),
                              ],
                            ),
                          ),
                        )
                      : watches.isEmpty
                          ? Center(
                              child: Text(
                                "No watches found",
                                style: GoogleFonts.inter(fontSize: 14.sp, color: AppColors.greyText),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.72,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                ),
                                itemCount: watches.length,
                                itemBuilder: (context, index) {
                                  final item = watches[index];
                                  return CustomCard(
                                    watch: item,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DetailedProductPage(watch: item),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Icon(Icons.menu, color: Colors.black87, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                height: 36.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.borderColor,
                    width: 1.w,
                  ),
                  color: Colors.grey[50],
                ),
                child: TextField(
                  onChanged: (val) => context.read<WatchProvider>().setSearchQuery(val),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined, size: 18.sp, color: AppColors.greyText),
                    hintText: "Search Product",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyText,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.h),
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
