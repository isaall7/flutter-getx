import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kuliner_controller.dart';
import 'kuliner_output.dart';

class KulinerView extends StatelessWidget {
  final KulinerController controller = Get.put(KulinerController());

  KulinerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Kuliner")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Nama Pembeli
              TextField(
                decoration: const InputDecoration(
                  labelText: "Nama Pembeli",
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => controller.namaPembeli.value = val,
              ),
              const SizedBox(height: 16),

              // Pilih Tanggal
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Tanggal: ${controller.formattedDate}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: controller.tanggalBeli.value,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            controller.tanggalBeli.value = picked;
                          }
                        },
                        child: const Text("Pilih"),
                      ),
                    ],
                  )),
              const SizedBox(height: 16),

              // Pilih Item (tidak pakai Obx untuk widget besar)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Pilih Makanan/Minuman",
                  border: OutlineInputBorder(),
                ),
                value: controller.itemDipilih.value.isEmpty
                    ? null
                    : controller.itemDipilih.value,
                items: controller.menu.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text("$e - Rp ${controller.menu[e]}"),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) controller.itemDipilih.value = val;
                },
              ),
              const SizedBox(height: 16),

              // Jumlah (jangan dibungkus Obx)
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Jumlah",
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  controller.jumlah.value = int.tryParse(val) ?? 0;
                },
              ),
              const SizedBox(height: 8),

              // Tombol tambah ke keranjang
              ElevatedButton(
                onPressed: () => controller.tambahItem(),
                child: const Text("Tambah ke Keranjang"),
              ),
              const SizedBox(height: 24),

              // List Keranjang (ini baru aman dibungkus Obx)
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Keranjang:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ...controller.keranjang.map(
                        (item) => ListTile(
                          title: Text(item.nama),
                          subtitle: Text(
                            "Jumlah: ${item.jumlah} x Rp ${item.harga}",
                          ),
                          trailing: Text("Rp ${item.total}"),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 24),

              // Submit
              ElevatedButton(
                onPressed: () {
                  if (controller.namaPembeli.value.isNotEmpty &&
                      controller.keranjang.isNotEmpty) {
                    Get.to(() => KulinerOutput(),
                        transition: Transition.rightToLeft);
                  } else {
                    Get.snackbar("Error", "Lengkapi data pembelian!");
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
