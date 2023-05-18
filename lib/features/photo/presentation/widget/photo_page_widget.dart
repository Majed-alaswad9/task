import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/util/snackbar_message.dart';
import 'package:task/core/widget/loading_widget.dart';
import 'package:task/features/photo/data/model/photo_model.dart';
import 'package:task/features/photo/presentation/bloc/get_posts/get_post_bloc.dart';
import 'package:task/features/photo/presentation/bloc/get_posts/get_post_event.dart';
import 'package:task/features/photo/presentation/pages/view_image.dart';

import '../bloc/get_posts/get_post_state.dart';

// ignore: must_be_immutable
class PhotoPageWidget extends StatefulWidget {
  final bool isSearch;
  String? query;
  PhotoPageWidget({Key? key, required this.isSearch, this.query})
      : super(key: key);

  @override
  State<PhotoPageWidget> createState() => _PhotoPageWidgetState();
}

class _PhotoPageWidgetState extends State<PhotoPageWidget> {
  final controller = ScrollController();
  int pagePhoto = 1;
  int pageSearch = 1;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (widget.isSearch) {
          pageSearch++;
          context
              .read<PhotoBloc>()
              .add(SearchPhotoEvent(widget.query!, pageSearch, false));
        } else {
          pagePhoto++;
          context.read<PhotoBloc>().add(GetPhotoEvent(pagePhoto, false));
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 50) / 2;
    final double itemWidth = size.width / 2;
    return BlocConsumer<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is ErrorGetPhotoState) {
          SnackBarMessage().snackBarMessageError(context, state.error);
        }
        if (state is ErrorSearchPhotoState) {
          SnackBarMessage().snackBarMessageError(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetPhotoState) {
          return const LoadingWidget();
        }
        if (state is SuccessGetPhotoState) {
          return _buildGridView(state.photoModel, itemWidth, itemHeight);
        } else if (state is SuccessSearchPhotoState) {
          return _buildGridView(state.photoModel, itemWidth, itemHeight);
        }
        return const LoadingWidget();
      },
    );
  }

  Widget _buildGridView(List<PhotoModel> photoModel, itemWidth, itemHeight) {
    return ConditionalBuilder(
      condition: photoModel.isNotEmpty,
      builder: (context) => GridView.count(
          padding: EdgeInsets.zero,
          childAspectRatio: (itemWidth / itemHeight),
          controller: controller,
          crossAxisCount: 2,
          children: List.generate(photoModel.length + 1, (index) {
            if (index < photoModel.length) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ViewImage(
                                photoModel: photoModel[index],
                                isFavourite: false,
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              );
            } else {
              return const Card(
                elevation: 5,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyan,
                    ),
                  ),
                ),
              );
            }
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
