import 'package:hive/hive.dart';
import 'package:navatech_assignment/data/datasources/album_remote_data_source.dart';
import 'package:navatech_assignment/data/datasources/photo_remote_data_source.dart';
import 'package:navatech_assignment/data/models/album_model.dart';
import 'package:navatech_assignment/data/models/photo.dart';

class AlbumRepository {
  final AlbumRemoteDataSource remote;
  final PhotoRemoteDataSource photoRemote;

  AlbumRepository(this.remote, this.photoRemote);

  Future<List<AlbumModel>> getAlbums() async {
    final box = await Hive.openBox<AlbumModel>('albums');
    if (box.isNotEmpty) return box.values.toList();

    final albums = await remote.fetchAlbums();
    await box.addAll(albums);
    return albums;
  }

  Future<List<Photo>> getPhotosForAlbum(int albumId) async {
    final box = await Hive.openBox<Photo>('photos_$albumId');
    if (box.isNotEmpty) return box.values.toList();

    final photos = await photoRemote.fetchPhotos(albumId);
    await box.addAll(photos);
    return photos;
  }
}
