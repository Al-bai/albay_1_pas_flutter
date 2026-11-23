import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:albay_1_pas_flutter/controllers/transaksi_controller.dart';
import 'package:albay_1_pas_flutter/components/primaryButton.dart';
import 'package:albay_1_pas_flutter/components/rincian_pembayaran_card.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransaksiController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaksi Pembelian",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Info Makanan Terpilih
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        controller.makanan.gambarPath,
                        width: 100,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 100,
                          height: 90,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.makanan.namaMakanan,
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Harga: ${controller.formatRupiah(controller.parseHarga(controller.makanan.harga))}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card Input Jumlah Makanan
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jumlah Makanan yang Dibeli",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        IconButton.filledTonal(
                          onPressed: controller.kurangJumlah,
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: controller.txtJumlah,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: controller.onJumlahChanged,
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton.filledTonal(
                          onPressed: controller.tambahJumlah,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Bayar menggunakan Reusable PrimaryButton
            PrimaryButton(
              text: "Bayar",
              onPressed: controller.prosesBayar,
            ),
            const SizedBox(height: 20),

            // Hasil Perhitungan (Subtotal, PPN 5%, Total Bayar) di layar menggunakan Reusable Component
            Obx(() {
              if (!controller.sudahHitung.value) {
                return const SizedBox.shrink();
              }

              return RincianPembayaranCard(
                subtotal: controller.formatRupiah(controller.subtotal.value),
                ppn: controller.formatRupiah(controller.ppn.value),
                totalBayar: controller.formatRupiah(controller.totalBayar.value),
              );
            }),
          ],
        ),
      ),
    );
  }
}
