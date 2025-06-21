import 'package:dio/dio.dart';
import 'package:navatech_assignment/data/models/photo.dart';

class PhotoRemoteDataSource {
  final Dio dio;

  PhotoRemoteDataSource(this.dio);
  Future<List<Photo>> fetchPhotos(int albumId) async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/photos',
      queryParameters: {'albumId': albumId},
    );
    return (response.data as List).map((e) => Photo.fromJson(e)).toList();
  }
}
