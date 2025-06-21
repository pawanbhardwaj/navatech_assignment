import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<dynamic>> fetchAlbumsPaginated(int start, int limit) async {
    final uri = Uri.parse('$_baseUrl/albums?_start=$start&_limit=$limit');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<String>> fetchPhotos(int albumId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/photos?albumId=$albumId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((photo) => photo['thumbnailUrl'] as String).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
