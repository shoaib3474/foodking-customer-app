import 'dart:async';

import 'package:get/get.dart';

import 'search_controller.dart';

class AnimatedHintController extends GetxController {
  final SearchController _searchController = Get.find<SearchController>();
  final RxString currentCategoryText = 'Search items...'.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    ever(_searchController.suggestionCategories, (_) {
      if (_searchController.suggestionCategories.isNotEmpty) {
        _startHintAnimation();
      }
    });
    if (_searchController.suggestionCategories.isNotEmpty) {
      _startHintAnimation();
    }
  }

  void _startHintAnimation() {
    _timer?.cancel();

    final List<String> categories = _searchController.suggestionCategories;

    if (categories.isEmpty) {
      currentCategoryText.value = 'Search items...';
      return;
    }
    int index = 0;

    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      if (categories.isEmpty) {
        timer.cancel();
        currentCategoryText.value = 'Search items...';
        return;
      }
      currentCategoryText.value = categories[index];

      index = (index + 1) % categories.length;
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }
}
