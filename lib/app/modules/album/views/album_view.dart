import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/album_controller.dart';

class AlbumView extends StatelessWidget {
  final AlbumController controller = Get.put(AlbumController());

  AlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Albums (GetX & GetConnect)"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.posts.isEmpty) {
          return const Center(
            child: Text(
              "No albums available",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final album = controller.posts[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    album.id.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  album.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text("User ID: ${album.userId}"),
                onTap: () {
                  Get.snackbar("Album Clicked", "Album ID: ${album.id}");
                  // Bisa diarahkan ke detail view kalau kamu buat
                },
              ),
            );
          },
        );
      }),
    );
  }
}
