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
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama Pembeli : ${controller.namaPembeli.value}"),
                Text("Tanggal Beli : ${controller.formattedDate}"),
                Text("Item : ${controller.itemDipilih.value}"),
                Text("Jumlah : ${controller.jumlah.value}"),
                Text("Total Harga : Rp ${controller.totalHarga}"),
                Text("Diskon : ${(controller.diskon * 100).toStringAsFixed(0)}%"),
                const Divider(),
                Text(
                  "Total Bayar : Rp ${controller.totalBayar.toStringAsFixed(0)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    controller.resetForm();
                    Get.back();
                  },
                  child: const Text("Kembali"),
                )
              ],
            )),
      ),
    );
  }
}
