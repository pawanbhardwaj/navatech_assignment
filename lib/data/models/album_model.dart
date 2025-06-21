import 'package:hive/hive.dart';

part 'album_model.g.dart';

@HiveType(typeId: 0)
class AlbumModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<String> images;

  AlbumModel({required this.id, required this.title, required this.images});

  factory AlbumModel.fromJson(Map<String, dynamic> json, List<String> images) =>
      AlbumModel(
        id: json['id'],
        title: json['title'],
        images: images,
      );
}
