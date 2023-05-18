import 'package:task/core/dio_helper.dart';
import 'package:task/core/errors/exceptions.dart';
import 'package:task/core/string/end_points.dart';

import '../model/photo_model.dart';

abstract class PhotoRemoteDataSource {
  Future<List<PhotoModel>> getPhoto(int page);

  Future<List<PhotoModel>> searchPhoto(String search, int page);
}

class PhotoRemoteDataSourceImplement implements PhotoRemoteDataSource {
  List<PhotoModel> photoModel = [];
  List<PhotoModel> response = [];
  @override
  Future<List<PhotoModel>> getPhoto(int page) async {
    if (page == 1) {
      photoModel = [];
    }
    await DioHelper.getData(
        url: photos,
        query: {'client_id': accessKey, 'page': page}).then((value) {
      for (var element in value.data) {
        photoModel.add(PhotoModel.fromJson(element));
      }
      return photoModel;
    }).catchError((_) {
      throw ServerException();
    });
    return photoModel;
  }

  @override
  Future<List<PhotoModel>> searchPhoto(String search, int page) async {
    if (page == 1) {
      response = [];
    }
    await DioHelper.getData(
            url: searchPhotos,
            query: {'client_id': accessKey, 'query': search, 'page': page})
        .then((value) {
      for (var data in value.data['results']) {
        response.add(PhotoModel.fromJson(data));
      }
      return response;
    }).catchError((_) {
      throw ServerException();
    });
    return response;
  }
}
