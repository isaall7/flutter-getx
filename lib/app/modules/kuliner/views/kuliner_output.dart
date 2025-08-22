import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kuliner_controller.dart';

class KulinerOutput extends StatelessWidget {
  final KulinerController controller = Get.find();

  KulinerOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Output Kuliner"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Detail Pembelian",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            title: const Text("Nama Pembeli"),
                            trailing: Text(controller.namaPembeli.value),
                          ),
                          ListTile(
                            title: const Text("Tanggal Beli"),
                            trailing: Text(controller.formattedDate),
                          ),
                          // 🔹 Tampilkan keranjang
                          ListTile(
                            title: const Text("Item & Jumlah"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: controller.keranjang
                                  .map((item) => Text(
                                      "${item.nama} x${item.jumlah} = Rp ${item.total}"))
                                  .toList(),
                            ),
                          ),
                          ListTile(
                            title: const Text("Total Harga"),
                            trailing: Text("Rp ${controller.totalHarga}"),
                          ),
                          ListTile(
                            title: const Text("Diskon"),
                            trailing: Text(
                                "${(controller.diskon * 100).toStringAsFixed(0)}%"),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text(
                              "Total Bayar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            trailing: Text(
                              "Rp ${controller.totalBayar.toStringAsFixed(0)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol Kembali
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        controller.resetForm();
                        Get.back();
                      },
                      child: const Text("Kembali"),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
