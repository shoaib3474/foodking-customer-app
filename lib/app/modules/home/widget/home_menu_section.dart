// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../menu/controllers/menu_controller.dart';
import 'category_selector_widget.dart';

Widget homeMenuSection() {
  return GetBuilder<MenuuController>(
    builder: (menuController) =>
        Column(children: [const CategorySelectorWidget()]),
  );
}
