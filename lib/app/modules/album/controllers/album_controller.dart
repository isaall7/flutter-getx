import 'package:ade_getx/app/modules/album/model/model_album.dart';
import 'package:ade_getx/app/modules/album/service/service_album.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {  
  var posts = <AlbumModel>[].obs;
  var isLoading = true.obs;

  final AlbumService _service = AlbumService();

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
 