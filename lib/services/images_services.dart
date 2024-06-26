import 'dart:convert';
import 'package:photo_gallery/models/image_model.dart';
import 'package:http/http.dart' as http;

class ImageServices {
  Future<List<ImageModel>> fetchImages(String query, int page) async {
    String url =
        'https://pixabay.com/api/?key=20554552-455e64c467a1f9052d37bd912&q=${query}&image_type=photo&pretty=true&page=${page}&per_page=20';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ((json.decode(response.body)['hits']) as List)
          .map((e) => ImageModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
