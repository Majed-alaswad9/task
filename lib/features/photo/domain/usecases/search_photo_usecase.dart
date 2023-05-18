import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/photo/data/model/photo_model.dart';
import '../repositories/photo_repository.dart';

class SearchPhotoUseCase {
  final PhotoRepository photoRepository;

  SearchPhotoUseCase(this.photoRepository);

  Future<Either<Failure, List<PhotoModel>>> call(
      String search, int page) async {
    return await photoRepository.searchPhoto(search, page);
  }
}
