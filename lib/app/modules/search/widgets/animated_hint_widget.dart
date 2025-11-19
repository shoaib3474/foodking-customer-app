import 'package:flutter/material.dart';
import 'package:foodking/util/style.dart';
import 'package:get/get.dart';

import '../controllers/animated_hint_controller.dart';

class AnimatedHint extends StatelessWidget {
  final AnimatedHintController controller = Get.find<AnimatedHintController>();
  AnimatedHint({super.key});

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(animation);

    final fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(position: offsetAnimation, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: _transitionBuilder,
        child: Text(
          controller.currentCategoryText.value,
          key: ValueKey<String>(controller.currentCategoryText.value),
          style: fontSizeSmallGray,
        ),
      );
    });
  }
}
