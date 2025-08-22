import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import 'post_detail_view.dart';

class PostView extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts (GetX & GetConnect)"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.posts.isEmpty) {
          return const Center(
            child: Text("No posts available"),
          );
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(
                  post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  // Pindah ke detail view
                  Get.to(() => PostDetailView(post: post));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
