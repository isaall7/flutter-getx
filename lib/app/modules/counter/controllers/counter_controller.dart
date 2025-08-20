import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  final count = 0.obs;

  void increment() {
    if (count.value < 50) {
      count.value++;
    } else {
      Get.snackbar(
        'Stop',
        'Maksimal 50',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
      );
    }
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    } else {
      Get.snackbar(
        'Stop',
        'Tidak boleh kurang dari 0',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
      );
    }
  }
}
