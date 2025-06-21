import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/album_model.dart';

class LocalDatabase {
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(AlbumModelAdapter());
    await Hive.openBox<AlbumModel>('albums');
  }
}
