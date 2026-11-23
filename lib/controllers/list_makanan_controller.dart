import 'package:albay_1_pas_flutter/models/makanan_model.dart';
import 'package:get/get.dart';

class ListMakananController extends GetxController {
  // data makanan berupa List, masih hardcoded

  List<MakananModel> dataMakanan = [
    MakananModel(
      namaMakanan: "Nasi Goreng Spesial",
      harga: "25.000",
      deskripsi: "Nasi goreng bumbu rempah dengan telur mata sapi, ayam suwir, dan kerupuk.",
      gambarPath: "assets/images/nasgor.jpg",
    ),
    MakananModel(
      namaMakanan: "Ayam Bakar Madu",
      harga: "30.000",
      deskripsi: "Ayam bakar olesan madu murni lengkap dengan sambal terasi dan lalapan.",
      gambarPath: "assets/images/ayambakar.jpg",
    ),
    MakananModel(
      namaMakanan: "Sate Ayam Madura",
      harga: "28.000",
      deskripsi: "10 tusuk sate ayam daging pilihan dengan siraman bumbu kacang kental.",
      gambarPath: "assets/images/Sateayammadura.jpg",
    ),
    MakananModel(
      namaMakanan: "Mie Ayam Bakso",
      harga: "20.000",
      deskripsi: "Mie kenyal dengan topping ayam kecap, sawi hijau, dan 2 butir bakso sapi.",
      gambarPath: "assets/images/miayambakso.jpg",
    ),
    MakananModel(
      namaMakanan: "Es Teh Manis Jumbo",
      harga: "8.000",
      deskripsi:
          "Minuman teh melati segar dengan gula asli dan es batu kristal.",
      gambarPath: "assets/images/esteh.jpg",
    ),
  ].obs;
}
