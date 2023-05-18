import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';

import '../../data/model/photo_model.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<PhotoModel>>> getPhotos(int page);
  Future<Either<Failure, List<PhotoModel>>> searchPhoto(
      String search, int page);
  Future<Either<Failure, List<PhotoModel>>> getLocalPhotos();
  Future<Unit> cachedPhoto(PhotoModel photoModel);
}
