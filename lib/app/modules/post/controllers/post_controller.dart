import 'package:ade_getx/app/modules/post/model/model_post.dart';
import 'package:ade_getx/app/modules/post/service/service_post.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  var posts = <PostModel>[].obs;
  var isLoading = true.obs;

  final PostService _service = PostService();

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  void getPosts() async {
    try {
      isLoading(true);
      var result = await _service.fetchPosts();
      posts.assignAll(result);
    } catch (e) {
      Get.snackbar("error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
