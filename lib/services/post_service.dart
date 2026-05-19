import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostService {
  static Future<List<PostModel>> getPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts?page=1&limit=10'),
    );
    if (response.statusCode == 200){
      List data = jsonDecode(response.body);
      return data.map((e) => PostModel.formJson(e)).toList();
    } else{
      throw Exception('Gagal mengambil data');
    }
  }
}