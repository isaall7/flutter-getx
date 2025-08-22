import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ItemBelanja {
  String nama;
  int harga;
  int jumlah;

  ItemBelanja({required this.nama, required this.harga, required this.jumlah});

  int get total => harga * jumlah;
}

class KulinerController extends GetxController {
  var namaPembeli = "".obs;
  var tanggalBeli = DateTime.now().obs;

  final Map<String, int> menu = {
    "Nasi Goreng": 25000,
    "Mie Ayam": 20000,
    "Soto Ayam": 22000,
    "Es Teh": 5000,
    "Es Jeruk": 7000,
    "Kopi": 10000,
  };

  // List belanja
  var keranjang = <ItemBelanja>[].obs;

  // Input sementara
  var itemDipilih = "".obs;
  var jumlah = 0.obs;

  // Tambah ke keranjang
  void tambahItem() {
    if (itemDipilih.value.isNotEmpty && jumlah.value > 0) {
      int harga = menu[itemDipilih.value] ?? 0;
      keranjang.add(ItemBelanja(
        nama: itemDipilih.value,
        harga: harga,
        jumlah: jumlah.value,
      ));
      // reset pilihan setelah ditambahkan
      itemDipilih.value = "";
      jumlah.value = 0;
    }
  }

  // 🔴 Hapus item berdasarkan index
  void hapusItem(int index) {
    if (index >= 0 && index < keranjang.length) {
      keranjang.removeAt(index);
    }
  }

  // 🔴 Hapus semua item di keranjang
  void hapusSemua() {
    keranjang.clear();
  }

  // Hitung total
  int get totalHarga =>
      keranjang.fold(0, (sum, item) => sum + item.total);

  double get diskon {
    if (totalHarga > 250000) return 0.10;
    if (totalHarga > 150000) return 0.05;
    return 0.0;
  }

  double get totalBayar => totalHarga - (totalHarga * diskon);

  String get formattedDate =>
      DateFormat('dd-MM-yyyy').format(tanggalBeli.value);

  void resetForm() {
    namaPembeli.value = "";
    tanggalBeli.value = DateTime.now();
    keranjang.clear();
    itemDipilih.value = "";
    jumlah.value = 0;
  }
}
