import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:albay_1_pas_flutter/controllers/detail_makanan_controller.dart';
import 'package:albay_1_pas_flutter/components/primaryButton.dart';

class DetailMakananPage extends StatelessWidget {
  const DetailMakananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailMakananController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.makanan.namaMakanan,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Makanan
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                controller.makanan.gambarPath,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.fastfood, size: 60, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nama Makanan
            Text(
              controller.makanan.namaMakanan,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Harga Makanan
            Text(
              "Harga: Rp ${controller.makanan.harga}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 16),

            // Deskripsi Makanan
            const Text(
              "Deskripsi:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              controller.makanan.deskripsi,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade800, height: 1.5),
            ),
            const SizedBox(height: 32),

            // Tombol Navigasi ke Halaman Transaksi menggunakan reusable PrimaryButton
            PrimaryButton(
              text: "Beli Sekarang",
              onPressed: controller.goToTransaksi,
            ),
          ],
        ),
      ),
    );
  }
}
