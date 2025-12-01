import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodking/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../app/modules/item/views/item_view.dart';
import '../util/constant.dart';

Widget itemCardGrid(item, index, context) {
  return InkWell(
    onTap: () async {
      await Get.find<HomeController>().getItemDetails(itemID: item[index].id!);
      showBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: ItemView(itemDetails: item[index], indexNumber: index),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow.withOpacity(0.1),
            blurRadius: 8.r,
            spreadRadius: 1.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image area with tag and overlay add button
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child: Container(
                  height: 140.h,
                  width: double.infinity,
                  color: AppColor.itembg,
                  child: CachedNetworkImage(
                    imageUrl: item[index].cover!,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                      child: Container(height: 140.h, color: Colors.grey),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              // Tag/label at top-left
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadow.withOpacity(0.15),
                        blurRadius: 4.r,
                      ),
                    ],
                  ),
                  child: Text(
                    item[index].tags != null && item[index].tags!.isNotEmpty
                        ? item[index].tags![0].toString()
                        : 'Featured',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              // Add button overlay at bottom-right
              Positioned(
                bottom: 8.w,
                right: 8.w,
                child: Container(
                  height: 36.r,
                  width: 36.r,
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.green.withOpacity(0.3),
                        blurRadius: 6.r,
                        spreadRadius: 1.r,
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 20.sp),
                ),
              ),
            ],
          ),

          // Product info section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product name
                Text(
                  item[index].name!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),

                // Rating and time row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Star rating
                    Icon(Icons.star, color: AppColor.yellow, size: 14.sp),
                    SizedBox(width: 3.w),
                    Text(
                      item[index].rating != null
                          ? item[index].rating.toString()
                          : '4.5',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.gray,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Time
                    Icon(
                      Icons.schedule,
                      color: AppColor.primaryColor,
                      size: 12.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '8 MINS',
                      style: TextStyle(fontSize: 10.sp, color: AppColor.gray),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Price section
                if (item[index].offer != null && item[index].offer.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item[index].offer[0].currencyPrice ?? '₹0',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: AppColor.gray,
                          fontSize: 10.sp,
                        ),
                      ),
                      Text(
                        item[index].currencyPrice ?? '₹0',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    item[index].currencyPrice ?? '₹0',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.fontColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
