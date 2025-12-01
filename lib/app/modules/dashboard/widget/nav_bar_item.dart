import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/constant.dart';

class BottomNavItem extends StatelessWidget {
  final AssetImage? imageData;
  final String? tittle;
  final VoidCallback? onTap;
  final bool isSelected;
  const BottomNavItem({
    super.key,
    this.imageData,
    this.tittle,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: isSelected ? 44.h : 36.h,
                width: isSelected ? 44.w : 36.w,
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.18),
                            blurRadius: 8.r,
                            spreadRadius: 1.r,
                          )
                        ]
                      : [],
                  border: Border.all(
                      color: isSelected
                          ? AppColor.primaryColor
                          : Colors.transparent),
                ),
                child: Center(
                  child: ImageIcon(
                    imageData,
                    color: isSelected ? Colors.white : AppColor.fontColor,
                    size: isSelected ? 22.sp : 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
