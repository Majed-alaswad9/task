import 'package:bloc/bloc.dart';
import 'package:task/features/photo/domain/usecases/get_photo_usecase.dart';
import 'package:task/features/photo/domain/usecases/search_photo_usecase.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/string/failure.dart';
import '../../../domain/usecases/cached_photo_usecase.dart';
import '../../../domain/usecases/get_local_photo_usecase.dart';
import 'get_photo_event.dart';
import 'get_photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotoUseCase getPhotoUseCase;
  final SearchPhotoUseCase searchPhotoUseCase;
  final GetPhotoLocalUseCase getPhotoLocalUseCase;
  final CachedPhotoUseCase cachedPhotoUseCase;

  PhotoBloc(this.getPhotoUseCase, this.searchPhotoUseCase,
      this.getPhotoLocalUseCase, this.cachedPhotoUseCase)
      : super(InitialPhotoState()) {
    on<GetPhotoEvent>((event, emit) async {
      if (event.isFirstLoader) {
        emit(LoadingGetPhotoState());
      }
      final successOrFailure = await getPhotoUseCase(event.page);
      successOrFailure.fold((l) {
        emit(ErrorGetPhotoState(_mapFailureToString(l)));
      }, (r) {
        emit(SuccessGetPhotoState(r));
      });
    });
    on<SearchPhotoEvent>((event, emit) async {
      if (event.isFirstLoader) {
        emit(LoadingSearchPhotoState());
      }
      final successOrFailure =
          await searchPhotoUseCase(event.search, event.page);
      successOrFailure.fold((l) {
        emit(ErrorSearchPhotoState(_mapFailureToString(l)));
      }, (r) {
        emit(SuccessSearchPhotoState(r));
      });
    });
    on<GetPhotoCachedEvent>((event, emit) async {
      emit(LoadingGetCachedPhotoState());
      final successOrFailure = await getPhotoLocalUseCase();
      successOrFailure.fold((l) {
        emit(ErrorGetCachedPhotoState(_mapFailureToString(l)));
      }, (r) {
        emit(SuccessGetCachedPhotoState(r));
      });
    });
    on<CachedPhotoLocalEvent>((event, emit) async {
      emit(SuccessCachedPhotoState());
    });
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE;
      case OfflineFailure:
        return OFFLINE_FAILURE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE;
      default:
        return "unExpected Error, pleas try again later";
    }
  }
}
