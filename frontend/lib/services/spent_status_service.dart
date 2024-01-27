import 'service.dart';

class SpentStatusService extends Service {
  Future<dynamic> get() async {
    final dio = getDio();
    final response = await dio.get('/spentstatus');

    return response.data;
  }

  Future<dynamic> getById(int id) async {
    final dio = getDio();
    final response = await dio.get('/spentstatus/$id');

    return response.data;
  }

  Future<dynamic> create(String description) async {
    final body = {
      "description": description
    };

    final dio = getDio();
    final response = await dio.post('/spentstatus', data: body);

    return response.data;
  }

  Future<dynamic> update(int id, String description) async {
    final body = {
      "idSpentStatus": id,
      "description": description
    };

    final dio = getDio();
    final response = await dio.put('/spentstatus', data: body);

    return response.data;
  }

  Future<dynamic> delete(int id) async {
    final dio = getDio();
    final response = await dio.delete('/spentstatus/$id');

    return response.data;
  }
}