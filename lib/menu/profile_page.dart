import 'package:flutter/material.dart';
import 'package:albay_1_pas_flutter/components/profile_info_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Data pembuat aplikasi (dapat disesuaikan dengan data Anda)
  final String namaLengkap = "Albay Haqy Alfarizky";
  final String kelas = "XI PPLG 2";
  final String noAbsen = "1";
  final String bio =
      "Siswa SMK yang antusias dalam bidang rekayasa perangkat lunak dan pengembangan gim";

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil Pembuat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Foto Profil menggunakan CircleAvatar
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: primaryColor.withValues(alpha: 0.15),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: primaryColor.withValues(alpha: 0.25),
                      child: Icon(Icons.person, size: 60, color: primaryColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Nama Lengkap
            Text(
              namaLengkap,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            // Role / Subtitle
            Text(
              "Belajar App Developing",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),

            // Card Identitas (Kelas & No. Absen)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          color: primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Data Akademik",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    ProfileInfoTile(
                      icon: Icons.school_outlined,
                      label: "Kelas",
                      value: kelas,
                      iconColor: primaryColor,
                    ),
                    const Divider(height: 12, thickness: 0.5),
                    ProfileInfoTile(
                      icon: Icons.format_list_numbered,
                      label: "Nomor Absen",
                      value: noAbsen,
                      iconColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card Bio Singkat
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.format_quote_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Bio Singkat",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    ProfileInfoTile(
                      icon: Icons.info_outline,
                      label: "Tentang Saya",
                      value: bio,
                      iconColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
