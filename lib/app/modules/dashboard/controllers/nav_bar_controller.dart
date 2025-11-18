import 'package:get/get.dart';

class NavBarController extends GetxController {
  var isVisible = true.obs;
  double lastScrollPosition = 0;
  final double scrollThreshold = 10.0;

  void updateVisibility(double currentScroll) {
    if ((currentScroll - lastScrollPosition).abs() > scrollThreshold) {
      if (currentScroll > lastScrollPosition) {
        // Scrolling down (Hide)
        if (isVisible.value) isVisible.value = false;
      } else {
        // Scrolling up (Show)
        if (!isVisible.value) isVisible.value = true;
      }
      lastScrollPosition = currentScroll;
    }
  }
}
