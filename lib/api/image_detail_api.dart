import 'dart:convert';

import 'package:poc_image/model/image_model.dart';
import 'package:http/http.dart' as http;
import 'package:poc_image/utils/api_exception.dart';
import 'package:poc_image/utils/urls.dart';

abstract class ImageRemoteDataSource {
  Future<ImageModel> getImage(int i);
}

class ImageRemoteDataSourceImplementation implements ImageRemoteDataSource{

  final http.Client _client=http.Client();

  @override
  Future<ImageModel> getImage(int i) async{
    try {
      final response = await _client.get(
        Uri.https(
            Urls.baseURL, "/$i"+Urls.getImageDetails),
      );
      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final data = jsonDecode(response.body);
      final imageDetail=ImageModel.fromMap(data);

      return imageDetail;
    } on APIException {
      rethrow;
    } catch (e) {
      // print(e.toString());
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}