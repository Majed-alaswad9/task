import 'package:task/features/photo/data/model/photo_model.dart';

abstract class PhotoState {}

class InitialPhotoState extends PhotoState {
  InitialPhotoState();
}

class LoadingGetPhotoState extends PhotoState {
  LoadingGetPhotoState();
}

class SuccessGetPhotoState extends PhotoState {
  final List<PhotoModel> photoModel;

  SuccessGetPhotoState(this.photoModel);
}

class ErrorGetPhotoState extends PhotoState {
  final String error;

  ErrorGetPhotoState(this.error);
}

class LoadingSearchPhotoState extends PhotoState {
  LoadingSearchPhotoState();
}

class SuccessSearchPhotoState extends PhotoState {
  final List<PhotoModel> photoModel;

  SuccessSearchPhotoState(this.photoModel);
}

class ErrorSearchPhotoState extends PhotoState {
  final String error;

  ErrorSearchPhotoState(this.error);
}

class LoadingGetCachedPhotoState extends PhotoState {
  LoadingGetCachedPhotoState();
}

class SuccessGetCachedPhotoState extends PhotoState {
  final List<PhotoModel> photoModel;

  SuccessGetCachedPhotoState(this.photoModel);
}

class ErrorGetCachedPhotoState extends PhotoState {
  final String error;

  ErrorGetCachedPhotoState(this.error);
}

class SuccessCachedPhotoState extends PhotoState {
  SuccessCachedPhotoState();
}
