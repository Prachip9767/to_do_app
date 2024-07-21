import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:to_do_app/model/to_do_model.dart';
import 'package:to_do_app/utils/api_url.dart';

class ApiService {
  Dio dio = Dio();

  Future<List<ToDoModel>> fetchList() async {
    try {
      final response = await dio.getUri(Uri.parse(ApiUrl.getApiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((e) => ToDoModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<void> addTodo(String title) async {
    try {
      final response = await dio.postUri(
        Uri.parse(ApiUrl.getApiUrl),
        data: jsonEncode({'title': title, 'completed': false}),
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final response = await dio.deleteUri(Uri.parse('${ApiUrl.getApiUrl}/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete todo');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}

