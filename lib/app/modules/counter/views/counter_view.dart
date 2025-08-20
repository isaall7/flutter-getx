import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/counter_controller.dart';

class CounterView extends GetView<CounterController> {
  CounterView({Key? key}) : super(key: key);
  final CounterController cont = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CounterView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (cont.count.value == 0) {
                return const SizedBox.shrink(); // tidak tampil apa-apa
              } else {
                return Text(
                  'Hitungan ke: ${cont.count.value}',
                  style: TextStyle(
                    fontSize: 20 + cont.count.value.toDouble(), // ukuran dinamis
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: cont.decrement,
                  child: const Text('Kurang'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: cont.increment,
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
