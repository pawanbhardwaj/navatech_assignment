import 'package:dio/dio.dart';
import 'package:navatech_assignment/data/models/album_model.dart';

class AlbumRemoteDataSource {
  final Dio dio;

  AlbumRemoteDataSource(this.dio);
  Future<List<AlbumModel>> fetchAlbums() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/albums');
    return (response.data as List)
        .map((e) => AlbumModel.fromJson(e, []))
        .toList();
  }
}
