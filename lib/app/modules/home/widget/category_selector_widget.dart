import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../menu/controllers/menu_controller.dart';
import '../../menu/views/menu_view.dart';

// Color scheme for different categories
final List<Color> categoryColors = [
  const Color(0xFFFFC400), // Primary Yellow
  const Color(0xFFFF6B6B), // Red
  const Color(0xFF4ECDC4), // Teal
  const Color(0xFFFFD93D), // Gold
  const Color(0xFF6BCB77), // Green
  const Color(0xFF4D96FF), // Blue
  const Color(0xFFFF8C42), // Orange
  const Color(0xFFA29BFE), // Purple
  const Color(0xFFFD79A8), // Pink
  const Color(0xFF55EFC4), // Mint
];

class CategorySelectorWidget extends StatefulWidget {
  const CategorySelectorWidget({super.key});

  @override
  State<CategorySelectorWidget> createState() => _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState extends State<CategorySelectorWidget> {
  int selectedCategoryIndex = 0;

  Color getCategoryColor(int index) {
    return categoryColors[index % categoryColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuuController>(
      builder: (menuController) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("OUR_MENU".tr, style: fontBold),
              InkWell(
                onTap: () {
                  Get.to(() => MenuView(fromHome: true, categoryId: 0));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 4.r, horizontal: 8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColor.primaryColor.withAlpha(30),
                  ),
                  child: Text("VIEW_ALL".tr, style: fontRegularBoldwithColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          menuController.categoryDataList.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(
                      menuController.categoryDataList.length,
                      (index) {
                        bool isSelected = selectedCategoryIndex == index;
                        Color categoryColor = getCategoryColor(index);

                        return Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                              });
                              Get.to(
                                () =>
                                    MenuView(fromHome: true, categoryId: index),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSelected ? 16.w : 12.w,
                                vertical: isSelected ? 10.h : 8.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: isSelected
                                    ? categoryColor
                                    : Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? categoryColor
                                      : Colors.grey[300]!,
                                  width: 2.w,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: categoryColor.withOpacity(0.3),
                                          blurRadius: 12.r,
                                          spreadRadius: 2.r,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                    width: 24.w,
                                    child: CachedNetworkImage(
                                      imageUrl: menuController
                                          .categoryDataList[index]
                                          .cover!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            child: Container(
                                              height: 24.h,
                                              width: 24.w,
                                              color: Colors.grey,
                                            ),
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[400]!,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error, size: 20),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    menuController.categoryDataList[index].name
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColor.fontColor,
                                      fontFamily: 'Rubik',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.grey,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
