import 'package:get/get.dart';
import 'package:albay_1_pas_flutter/models/makanan_model.dart';
import 'package:albay_1_pas_flutter/routes.dart';

class DetailMakananController extends GetxController {
  late MakananModel makanan;

  @override
  void onInit() {
    super.onInit();
  
    makanan = Get.arguments as MakananModel;
  }

 
  void goToTransaksi() {
    Get.toNamed(Routes.transaksi, arguments: makanan);
  }
}
