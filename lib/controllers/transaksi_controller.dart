import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:albay_1_pas_flutter/models/makanan_model.dart';

class TransaksiController extends GetxController {
  late MakananModel makanan;

  // Controller input jumlah makanan
  final TextEditingController txtJumlah = TextEditingController(text: "1");
  final RxInt jumlah = 1.obs;

  // Variabel reactive untuk hasil perhitungan transaksi
  final RxDouble subtotal = 0.0.obs;
  final RxDouble ppn = 0.0.obs;
  final RxDouble totalBayar = 0.0.obs;
  final RxBool sudahHitung = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Menerima data makanan yang dikirim lewat Get.arguments
    makanan = Get.arguments as MakananModel;
  }

  /// Helper untuk mengambil angka murni dari string harga (misal "25.000" -> 25000.0)
  double parseHarga(String hargaStr) {
    String clean = hargaStr.replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(clean) ?? 0.0;
  }

  /// Helper untuk format ke Rupiah (misal 25000 -> "Rp 25.000")
  String formatRupiah(num number) {
    int intVal = number.round();
    String str = intVal.toString();
    String formatted = str.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }

  /// Menambah jumlah makanan (+1)
  void tambahJumlah() {
    jumlah.value++;
    txtJumlah.text = jumlah.value.toString();
    if (sudahHitung.value) {
      hitung();
    }
  }

  /// Mengurangi jumlah makanan (-1, minimal 1)
  void kurangJumlah() {
    if (jumlah.value > 1) {
      jumlah.value--;
      txtJumlah.text = jumlah.value.toString();
      if (sudahHitung.value) {
        hitung();
      }
    }
  }

  /// Ketika nilai input jumlah diubah langsung di TextField
  void onJumlahChanged(String val) {
    int? parsed = int.tryParse(val);
    if (parsed != null && parsed > 0) {
      jumlah.value = parsed;
      if (sudahHitung.value) {
        hitung();
      }
    }
  }

  /// Rumus Perhitungan Transaksi:
  /// Subtotal = Harga Makanan × Jumlah Makanan
  /// PPN (5%) = Subtotal × 0.05
  /// Total Bayar = Subtotal + PPN (5%)
  void hitung() {
    int qty = int.tryParse(txtJumlah.text) ?? jumlah.value;
    if (qty <= 0) qty = 1;

    double hargaMakanan = parseHarga(makanan.harga);
    subtotal.value = hargaMakanan * qty;
    ppn.value = subtotal.value * 0.05;
    totalBayar.value = subtotal.value + ppn.value;
    sudahHitung.value = true;
  }

  /// Aksi ketika tombol Bayar ditekan
  void prosesBayar() {
    int? qty = int.tryParse(txtJumlah.text);
    if (qty == null || qty <= 0) {
      Get.snackbar(
        "Peringatan",
        "Jumlah makanan minimal harus 1!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    jumlah.value = qty;
    hitung();

    // Tampilkan dialog konfirmasi pembayaran
    tampilkanDialogKonfirmasi();
  }

  /// Dialog konfirmasi menampilkan rincian perhitungan
  void tampilkanDialogKonfirmasi() {
    Get.defaultDialog(
      title: "Konfirmasi Pembelian",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                makanan.gambarPath,
                width: 140,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 140,
                  height: 90,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            makanan.namaMakanan,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text("Harga Satuan: ${formatRupiah(parseHarga(makanan.harga))}"),
          Text("Jumlah Makanan: ${jumlah.value} porsi"),
          const Divider(thickness: 1, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal:"),
              Text(
                formatRupiah(subtotal.value),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("PPN (5%):"),
              Text(
                formatRupiah(ppn.value),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Divider(thickness: 1, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Bayar:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                formatRupiah(totalBayar.value),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Get.back();
          Get.snackbar(
            "Berhasil",
            "Transaksi untuk ${makanan.namaMakanan} berhasil diproses!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        },
        child: const Text("Selesai"),
      ),
      cancel: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => Get.back(),
        child: const Text("Tutup"),
      ),
    );
  }

  @override
  void onClose() {
    txtJumlah.dispose();
    super.onClose();
  }
}
