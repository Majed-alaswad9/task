import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';

import '../../data/model/photo_model.dart';
import '../repositories/photo_repository.dart';

class GetPhotoUseCase {
  final PhotoRepository photoRepository;

  GetPhotoUseCase(this.photoRepository);

  Future<Either<Failure, List<PhotoModel>>> call(int page) async {
    return await photoRepository.getPhotos(page);
  }
}
