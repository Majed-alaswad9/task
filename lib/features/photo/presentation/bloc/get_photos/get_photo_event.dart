import 'package:task/features/photo/data/model/photo_model.dart';

abstract class PhotoEvent {}

class GetPhotoEvent extends PhotoEvent {
  final bool isFirstLoader;
  final int page;
  GetPhotoEvent(this.page, this.isFirstLoader);
}

class SearchPhotoEvent extends PhotoEvent {
  final String search;
  final int page;
  final bool isFirstLoader;

  SearchPhotoEvent(this.search, this.page, this.isFirstLoader);
}

class CachedPhotoLocalEvent extends PhotoEvent {
  final PhotoModel photoModel;

  CachedPhotoLocalEvent(this.photoModel);
}

class GetPhotoCachedEvent extends PhotoEvent {
  GetPhotoCachedEvent();
}
