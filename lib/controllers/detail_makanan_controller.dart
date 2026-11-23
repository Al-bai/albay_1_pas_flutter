import 'package:get/get.dart';
import 'package:albay_1_pas_flutter/models/makanan_model.dart';
import 'package:albay_1_pas_flutter/routes.dart';

class DetailMakananController extends GetxController {
  late MakananModel makanan;

  @override
  void onInit() {
    super.onInit();
    // Menerima data makanan yang dikirim lewat Get.arguments
    makanan = Get.arguments as MakananModel;
  }

  /// Pindah ke Halaman Transaksi Pembelian via Routes
  void goToTransaksi() {
    Get.toNamed(Routes.transaksi, arguments: makanan);
  }
}
