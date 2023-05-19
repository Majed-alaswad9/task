import 'package:dartz/dartz.dart';
import 'package:task/core/errors/exceptions.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/core/network_info.dart';
import 'package:task/features/photo/data/datasources/photo_local_datasource.dart';

import '../../domain/repositories/photo_repository.dart';
import '../datasources/photo_remote_datasource.dart';
import '../model/photo_model.dart';

class PhotoRepositoryImplement implements PhotoRepository {
  final PhotoRemoteDataSource photoRemoteDataSource;
  final PhotoLocalDataSource photoLocalDataSource;
  final NetworkInfo networkInfo;

  PhotoRepositoryImplement(
      this.photoRemoteDataSource, this.networkInfo, this.photoLocalDataSource);

  @override
  Future<Either<Failure, List<PhotoModel>>> getPhotos(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final photoModel = await photoRemoteDataSource.getPhoto(page);
        return Right(photoModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<PhotoModel>>> searchPhoto(
      String search, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await photoRemoteDataSource.searchPhoto(search, page);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Unit> cachedPhoto(PhotoModel photoModel) async {
    final response = await getLocalPhotos();
    List<PhotoModel> cache = [];
    response.fold((l) {
      cache.add(photoModel);
    }, (r) {
      for (var element in r) {
        if (element.id != photoModel.id) {
          cache.add(element);
        }
      }
      cache.add(photoModel);
    });
    await photoLocalDataSource.cachedLocalPhoto(cache);
    return Future.value(unit);
  }

  @override
  Future<Either<Failure, List<PhotoModel>>> getLocalPhotos() async {
    try {
      final photoModel = await photoLocalDataSource.getLocalPhoto();
      return Right(photoModel);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }
}
