import 'package:get/get.dart';
import 'package:albay_1_pas_flutter/pages/login.dart';
import 'package:albay_1_pas_flutter/pages/main_menu.dart';
import 'package:albay_1_pas_flutter/pages/detail_makanan_page.dart';
import 'package:albay_1_pas_flutter/pages/transaksi_page.dart';

class Routes {
  static const String login = "/login";
  static const String main_menu = "/main_menu";
  static const String detail_makanan = "/detail_makanan";
  static const String transaksi = "/transaksi";

  static final myPages = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: main_menu, page: () => MainMenu()),
    GetPage(name: detail_makanan, page: () => const DetailMakananPage()),
    GetPage(name: transaksi, page: () => const TransaksiPage()),
  ];
}
