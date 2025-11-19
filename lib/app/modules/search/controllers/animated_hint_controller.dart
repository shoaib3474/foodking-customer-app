import 'dart:async';

import 'package:get/get.dart';

class AnimatedHintController extends GetxController {
  final List<String> animationCategories = const [
    'Search for Pizza...',
    'Search for Burgers...',
    'Search for Pasta...',
    'Search for Drinks...',
  ];

  final RxString currentCategoryText = 'Search items...'.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startHintAnimation();
  }

  void _startHintAnimation() {
    _timer?.cancel();

    final List<String> categories = animationCategories;

    if (categories.isEmpty) {
      currentCategoryText.value = 'Search items...';
      return;
    }

    currentCategoryText.value = categories[0];

    int index = 1 % categories.length;

    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
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
