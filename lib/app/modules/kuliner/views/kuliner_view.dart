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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Form Kuliner",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- Card Input Data ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Nama Pembeli
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Nama Pembeli",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
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
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ElevatedButton.icon(
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
                              icon: const Icon(Icons.calendar_today, size: 18),
                              label: const Text("Pilih"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 16),

                    // Pilih Item (dibungkus Obx agar reaktif)
                    Obx(() => DropdownButtonFormField<String>(
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
                        )),
                    const SizedBox(height: 16),

                    // Jumlah
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Jumlah",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.format_list_numbered),
                      ),
                      onChanged: (val) {
                        controller.jumlah.value = int.tryParse(val) ?? 0;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Tombol tambah ke keranjang
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => controller.tambahItem(),
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text("Tambah ke Keranjang"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- List Keranjang ---
            Obx(() => controller.keranjang.isEmpty
                ? const Text("Keranjang masih kosong",
                    style: TextStyle(fontSize: 16, color: Colors.grey))
                : Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Keranjang:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          const Divider(),
                         ...controller.keranjang.asMap().entries.map(
                          (entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return ListTile(
                              leading: const Icon(Icons.fastfood, color: Colors.teal),
                              title: Text(item.nama),
                              subtitle: Text("Jumlah: ${item.jumlah} x Rp ${item.harga}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Rp ${item.total}",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => controller.hapusItem(index),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        ],
                      ),
                    ),
                  )),
            const SizedBox(height: 24),

            // --- Submit ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.namaPembeli.value.isNotEmpty &&
                      controller.keranjang.isNotEmpty) {
                    Get.to(() => KulinerOutput(),
                        transition: Transition.rightToLeft);
                  } else {
                    Get.snackbar("Error", "Lengkapi data pembelian!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red[300],
                        colorText: Colors.white);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
