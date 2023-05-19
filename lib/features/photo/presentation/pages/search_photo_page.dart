import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_photos/get_photo_bloc.dart';
import '../bloc/get_photos/get_photo_event.dart';
import 'package:task/injection_container.dart' as di;

import '../widget/photo_page_widget.dart';

class SearchPhotoPage extends StatelessWidget {
  final String query;
  const SearchPhotoPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            di.sl<PhotoBloc>()..add(SearchPhotoEvent(query, 1, true)),
        child: PhotoPageWidget(
          isSearch: true,
          query: query,
        ));
  }
}
