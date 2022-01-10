import 'package:pixabay_provider/model/picture_result.dart';

abstract class PhotoApi {
  Future<List<Picture>> fetchPhotos(String query);
}
