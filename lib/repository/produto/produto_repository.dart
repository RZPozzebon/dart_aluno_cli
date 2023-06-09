import 'package:dio/dio.dart';
import '../../models/courses.dart';

class ProdutoRepository {
  Future<Courses> findByName(String name) async {
    try {
      final response = await Dio().get(
        'http://localhost:8080/products',
        queryParameters: {'name': name},
      );

      if (response.data.isEmpty) {
        throw Exception('Produto não encontrato');
      }
      return Courses.fromMap(response.data.first);
    } on DioError catch (e) {
      throw Exception();
    }
  }
}
