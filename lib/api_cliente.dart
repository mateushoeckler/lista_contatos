import 'package:dio/dio.dart';

class ApiCliente{

  ///Altere o dio conforme necessário
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com'
    )
  );

  Future<DateTime> getDateTime(int id) async{
    ///Altere o path conforme necessário
    return await dio.get('/todos/$id').then((response){

      ///Estou setando um novo valor fake para o response, faça as devidas alterações na API real
      response = Response(data: DateTime.now(), requestOptions: RequestOptions());
      return response.data;
    });
  }

}