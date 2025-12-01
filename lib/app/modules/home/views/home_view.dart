// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../widget/loader.dart';
import '../../search/controllers/animated_hint_controller.dart';
import '../../offer/controllers/offer_controller.dart';
import '../../menu/controllers/menu_controller.dart';
import '../../search/views/search_view.dart';
                        return SliverAppBar(
                          pinned: true,
                          // toolbar + bottom heights
                          expandedHeight: kToolbarHeight + 200.h,
                          backgroundColor: bgColor,
                          elevation: 0,
                          leadingWidth: 100.w,
                          leading: Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Image.asset(Images.logo, width: 85.w),
                          ),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Get.to(() => const ProfileView());
                              },
                              icon: Icon(
                                Icons.person,
                                color: iconColor,
                                size: 24.sp,
                              ),
                            ),
                          ],
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(200.h),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, bottom: 12.h, top: 8.h),
                              child: Column(
                                children: [
                                  // Search TextField (stays visible when pinned)
                                  SizedBox(
                                    child: homeController.loader
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[200]!,
                                            highlightColor:
                                                Colors.grey[300]!,
                                            child: Container(
                                              height: 52.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            child: TextField(
                                              showCursor: true,
                                              readOnly: true,
                                              onTap: () {
                                                Get.to(() => const SearchView());
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 0.w,
                                                  vertical: 0.h,
                                                ),
                                                hintText: "",
                                                label: AnimatedHint(),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                prefixIcon: SizedBox(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(12.r),
                                                    child: SvgPicture.asset(
                                                      Images.iconSearch,
                                                      fit: BoxFit.cover,
                                                      color: AppColor.gray,
                                                      height: 16.h,
                                                      width: 16.w,
                                                    ),
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: AppColor.itembg,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(12.r),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color:
                                                        AppColor.primaryColor,
                                                    width: 1.w,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(12.r),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 0.w,
                                                    color: AppColor.itembg,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(height: 14.h),
                                  // Category Selector (stays visible when pinned)
                                  homeController.menuLoader ||
                                          homeController
                                              .categoryDataList.isEmpty
                                      ? menuSectionShimmer()
                                      : homeMenuSection(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                                              onTap: () {
                                                Get.to(
                                                  () => const SearchView(),
                                                );
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 0.w,
                                                      vertical: 0.h,
                                                    ),
                                                hintText: "",
                                                label: AnimatedHint(),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                prefixIcon: SizedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                      12.r,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      Images.iconSearch,
                                                      fit: BoxFit.cover,
                                                      color: AppColor.gray,
                                                      height: 16.h,
                                                      width: 16.w,
                                                    ),
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: AppColor.itembg,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            Radius.circular(
                                                              12.r,
                                                            ),
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: AppColor
                                                            .primaryColor,
                                                        width: 1.w,
                                                      ),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            Radius.circular(
                                                              12.r,
                                                            ),
                                                          ),
                                                      borderSide: BorderSide(
                                                        width: 0.w,
                                                        color: AppColor.itembg,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(height: 14.h),
                                  // Category Selector
                                  homeController.menuLoader ||
                                          homeController
                                              .categoryDataList
                                              .isEmpty
                                      ? menuSectionShimmer()
                                      : homeMenuSection(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    // Main content
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            homeController.activeOrderData.isEmpty ||
                                box.read('isLogedIn') == false
                            ? EdgeInsets.only(left: 16.h, right: 16.h)
                            : EdgeInsets.only(
                                left: 16.h,
                                right: 16.h,
                                bottom: 100.h,
                              ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                homeController.featuredLoader ||
                                        homeController
                                            .featuredItemDataList
                                            .isEmpty
                                    ? featureditemSectionShimmer()
                                    : featureditemSection(),
                                Get.find<OfferController>()
                                            .offerDataList
                                            .isEmpty ||
                                        Get.find<OfferController>().lodear
                                    ? const SizedBox.shrink()
                                    : homeOfferSection(),
                                homeController.popularLoader ||
                                        homeController
                                            .popularItemDataList
                                            .isEmpty
                                    ? popularItemSectionShimmer()
                                    : popularItemSection(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (homeController.activeOrderData.isNotEmpty &&
                  box.read('isLogedIn') == true)
                const ActiveOrderStatus(),

              Get.find<OfferController>().offerItemlodear
                  ? Positioned(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white60,
                        child: const Center(child: LoaderCircle()),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
