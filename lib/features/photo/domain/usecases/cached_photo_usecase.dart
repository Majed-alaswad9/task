import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/photo/data/model/photo_model.dart';
import 'package:task/features/photo/domain/repositories/photo_repository.dart';

class CachedPhotoUseCase {
  final PhotoRepository photoRepository;

  CachedPhotoUseCase(this.photoRepository);

  Future<Unit> call(PhotoModel photoModel) async {
    return await photoRepository.cachedPhoto(photoModel);
  }
}
