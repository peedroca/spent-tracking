import 'service.dart';

class SpentCategoryService extends Service {
  Future<dynamic> get() async {
    final dio = getDio();
    final response = await dio.get('/spentcategory');

    return response.data;
  }

  Future<dynamic> getById(int id) async {
    final dio = getDio();
    final response = await dio.get('/spentcategory/$id');

    return response.data;
  }

  Future<dynamic> create(String description) async {
    final body = {
      "description": description
    };

    final dio = getDio();
    final response = await dio.post('/spentcategory', data: body);

    return response.data;
  }

  Future<dynamic> update(int id, String description) async {
    final body = {
      "idSpentCategory": id,
      "description": description
    };

    final dio = getDio();
    final response = await dio.put('/spentcategory', data: body);

    return response.data;
  }

  Future<dynamic> delete(int id) async {
    final dio = getDio();
    final response = await dio.delete('/spentcategory/$id');

    return response.data;
  }
}