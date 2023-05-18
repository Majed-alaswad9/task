import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/errors/exceptions.dart';
import 'package:task/features/photo/data/model/photo_model.dart';

abstract class PhotoLocalDataSource {
  Future<List<PhotoModel>> getLocalPhoto();
  Future<Unit> cachedLocalPhoto(List<PhotoModel> photoModel);
}

class PhotoLocalDataSourceImplement implements PhotoLocalDataSource {
  final SharedPreferences sharedPreferences;

  PhotoLocalDataSourceImplement(this.sharedPreferences);
  @override
  Future<Unit> cachedLocalPhoto(List<PhotoModel> photoModel) {
    List photoModelToJson =
        photoModel.map<Map<String, dynamic>>((e) => e.toJson()).toList();
    sharedPreferences.setString("CACHED_PHOTO", json.encode(photoModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PhotoModel>> getLocalPhoto() {
    final jsonString = sharedPreferences.getString("CACHED_PHOTO");
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PhotoModel> jsonToPhotoModel = decodeJsonData
          .map<PhotoModel>((element) => PhotoModel.fromLocalJson(element))
          .toList();
      return Future.value(jsonToPhotoModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
