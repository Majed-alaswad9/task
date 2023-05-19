import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/string/failure.dart';
import 'package:task/core/util/snackbar_message.dart';
import 'package:task/core/widget/loading_widget.dart';
import 'package:task/features/photo/data/model/photo_model.dart';
import 'package:task/features/photo/presentation/pages/view_image.dart';

import '../bloc/get_photos/get_photo_bloc.dart';
import '../bloc/get_photos/get_photo_state.dart';

// ignore: must_be_immutable
class FavouritePhotoPageWidget extends StatelessWidget {
  const FavouritePhotoPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 50) / 2;
    final double itemWidth = size.width / 2;
    return BlocConsumer<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is ErrorGetCachedPhotoState) {
          SnackBarMessage().snackBarMessageError(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetCachedPhotoState) {
          return const LoadingWidget();
        }
        if (state is SuccessGetCachedPhotoState) {
          return _buildGridView(state.photoModel, itemWidth, itemHeight);
        } else if (state is ErrorGetCachedPhotoState) {
          if (state.error == EMPTY_CACHE_FAILURE) {
            return const Center(
                child: Text(
              'NO Favourite Photo',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ));
          }
        }
        return const LoadingWidget();
      },
    );
  }

  Widget _buildGridView(List<PhotoModel> photoModel, itemWidth, itemHeight) {
    return ConditionalBuilder(
      condition: photoModel.isNotEmpty,
      builder: (context) => GridView.count(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 2,
          children: List.generate(photoModel.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ViewImage(
                              photoModel: photoModel[index],
                              isFavourite: true,
                            )));
              },
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 5,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: photoModel[index].urlPhoto,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyan,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            );
          })),
      fallback: (context) => const Center(
          child: Text(
        '     ＞︿＜ \n No Photos',
        style: TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }
}
