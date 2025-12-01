import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'item_caution.dart';
import '../app/modules/item/views/item_view.dart';
import '../util/constant.dart';
import '../util/style.dart';

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
      height: 260.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        border: Border.all(color: AppColor.itembg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area with top-left tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: Container(
                  height: 120.h,
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
                      child: Container(height: 120.h, color: Colors.grey),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              // Tag/pill
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    item[index].tags != null && item[index].tags.isNotEmpty
                        ? item[index].tags[0].toString()
                        : 'Imported',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product info
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item[index].name!,
                  style: fontRegularBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // rating (if available)
                    Icon(Icons.star, color: AppColor.yellow, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      item[index].rating != null
                          ? item[index].rating.toString()
                          : '4.5',
                      style: TextStyle(fontSize: 12.sp, color: AppColor.gray),
                    ),
                    SizedBox(width: 12.w),
                    // time
                    Icon(Icons.access_time, color: AppColor.primaryColor, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text('8 MINS', style: TextStyle(fontSize: 12.sp, color: AppColor.gray)),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    item[index].offer.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item[index].offer[0].currencyPrice!,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColor.gray,
                                    fontSize: 12.sp),
                              ),
                              Text(item[index].currencyPrice!, style: fontMediumProWithCurrency),
                            ],
                          )
                        : Text(item[index].currencyPrice!, style: fontMediumProWithCurrency),
                    // placeholder for spacing - add button is overlayed below
                    const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),

          // bottom spacing to fit overlay add button
          SizedBox(height: 8.h),
        ],
      ),
    ),
  );
}
