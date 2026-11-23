import 'package:flutter/material.dart';
import 'package:albay_1_pas_flutter/menu/feat_page.dart';
import 'package:albay_1_pas_flutter/menu/home_page.dart';
import 'package:albay_1_pas_flutter/menu/profile_page.dart';
import 'package:get/get.dart';

class MainMenuController extends GetxController{
  final RxInt selectedIndex = 0.obs;

  void changePage(int index){
    selectedIndex.value = index;
  }

  List<Widget> listPages = [HomePage(), FeatPage(), ProfilePage()];

}