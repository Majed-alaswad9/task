import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/photo/data/model/photo_model.dart';
import 'package:task/features/photo/domain/repositories/photo_repository.dart';

class GetPhotoLocalUseCase {
  final PhotoRepository photoRepository;

  GetPhotoLocalUseCase(this.photoRepository);

  Future<Either<Failure, List<PhotoModel>>> call() async {
    return await photoRepository.getLocalPhotos();
  }
}
