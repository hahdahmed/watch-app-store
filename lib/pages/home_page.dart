import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/models/watchcardmodel.dart';
import 'package:watch_app/pages/detailedprodect.dart';
import 'package:watch_app/widgets/CustomCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int selectIndex = -1;

List<String> WatchesType = ["Smart watch", "Casio", "Tissot", "Seiko"];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),

      body: Column(
        children: [
          SizedBox(height: 10.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Find your suitable\n watch now.",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: SizedBox(
              height: 30.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  bool isSelect = index == selectIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          WatchesType[index],
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: isSelect
                                  ? Color(0xffF24E1E)
                                  : Color(0xff9095A6),
                            ),
                          ),
                        ),

                        if (isSelect)
                          Container(
                            width: 38.w,
                            height: 1.6.h,
                            color: Color(0xffF24E1E),
                          ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => SizedBox(width: 20.w),
                itemCount: WatchesType.length,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.90,
                ),
                itemCount: watchItem.length,
                itemBuilder: (context, index) {
                  final item = watchItem[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => Detailedprodect(
                            image: item.image,
                            title: item.title,
                            price: item.price,
                          ),
                        ),
                      );
                    },
                    child: Customcard(
                      image: item.image,
                      title: item.title,
                      brand: item.subtitle,
                      price: item.price,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu),

            SizedBox(width: 50.w),
            Expanded(
              child: Container(
                height: 25.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: Color.fromARGB(209, 217, 217, 217),
                    width: 1.w,
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined, size: 20.w),
                    hintText: "Search Product",

                    hintStyle: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
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
