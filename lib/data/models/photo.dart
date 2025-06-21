import 'package:hive/hive.dart';

part 'photo.g.dart';

@HiveType(typeId: 1)
class Photo extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int albumId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String thumbnailUrl;

  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      albumId: json['albumId'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
