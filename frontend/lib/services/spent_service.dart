import 'service.dart';

class SpentService extends Service {
  Future<dynamic> get() async {
    final dio = getDio();
    final response = await dio.get('/spent');

    return response.data;
  }

  Future<dynamic> getById(int id) async {
    final dio = getDio();
    final response = await dio.get('/spent/$id');

    return response.data;
  }

  Future<dynamic> create(String category, String status, String description, num amount) async {
    final body = {
      "category": category,
      "status": status,
      "description": description,
      "amount": amount
    };

    final dio = getDio();
    final response = await dio.post('/spent', data: body);

    return response.data;
  }

  // Future<dynamic> update(int id, String description) async {
  //   final body = {
  //     "idSpent": id,
  //     "description": description
  //   };

  //   final dio = getDio();
  //   final response = await dio.put('/spent', data: body);

  //   return response.data;
  // }

  // Future<dynamic> delete(int id) async {
  //   final dio = getDio();
  //   final response = await dio.delete('/spent/$id');

  //   return response.data;
  // }
}