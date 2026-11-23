import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:albay_1_pas_flutter/controllers/feat_controller.dart';

class FeatPage extends StatelessWidget {
  const FeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FeatController controller = Get.put(FeatController());

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sports_soccer, size: 24),
            SizedBox(width: 8),
            Text(
              "Premier League",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 12),
                Text(
                  "Memuat data tim...",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        if (controller.teamList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.sports_soccer, size: 60, color: Colors.grey),
                const SizedBox(height: 12),
                const Text(
                  "Tidak ada data tim ditemukan",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: controller.fetchTeams,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Muat Ulang"),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.fetchTeams(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            itemCount: controller.teamList.length,
            itemBuilder: (context, index) {
              final team = controller.teamList[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: [
                      // Logo Klub (strBadge)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(4),
                          color: Colors.grey.shade100,
                          child: team.strBadge.isNotEmpty
                              ? Image.network(
                                  team.strBadge,
                                  width: 52,
                                  height: 52,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.shield_outlined,
                                    size: 32,
                                    color: Colors.grey,
                                  ),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Icon(
                                  Icons.shield_outlined,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Nama Klub (strTeam) & Nama Stadion (strStadium)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              team.strTeam,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.stadium_outlined,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    team.strStadium.isNotEmpty
                                        ? team.strStadium
                                        : "Stadion tidak diketahui",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
