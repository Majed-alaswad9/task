import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/photo/presentation/bloc/get_posts/get_post_bloc.dart';
import 'package:task/features/photo/presentation/bloc/get_posts/get_post_event.dart';
import 'package:task/features/photo/presentation/widget/favourite_page_widget.dart';
import 'package:task/features/photo/presentation/widget/photo_page_widget.dart';
import 'package:task/injection_container.dart' as di;

import '../../../../core/util/search_delegate.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(appBar: _appBar(context), body: _buildBody()));
  }

  AppBar _appBar(context) => AppBar(
        title: const Text('Photos'),
        bottom: const TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MySearchDelegate()),
              icon: const Icon(Icons.search))
        ],
      );

  Widget _buildBody() {
    return TabBarView(children: [
      BlocProvider(
        create: (_) => di.sl<PhotoBloc>()..add(GetPhotoEvent(1, true)),
        child: PhotoPageWidget(
          isSearch: false,
        ),
      ),
      BlocProvider(
          create: (_) => di.sl<PhotoBloc>()..add(GetPhotoCachedEvent()),
          child: const FavouritePhotoPageWidget())
    ]);
  }
}
