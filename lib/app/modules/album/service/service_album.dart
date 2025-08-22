import 'package:get/get.dart';
import 'package:ade_getx/app/modules/album/model/model_album.dart';

class AlbumService extends GetConnect {
  Future<List<AlbumModel>> fetchPosts() async {
    final response = await get("https://jsonplaceholder.typicode.com/albums");

    if (response.status.hasError) {
      return Future.error(response.statusText ?? "Error fetching posts");
    } else {
      final List<dynamic> data = response.body;
      return data.map((e) => AlbumModel.fromJson(e)).toList();
    }
  }
}
