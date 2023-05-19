import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task/core/theme.dart';
import 'package:task/core/util/snackbar_message.dart';
import 'package:task/features/photo/data/model/photo_model.dart';
import 'package:task/injection_container.dart' as di;

import '../bloc/get_photos/get_photo_bloc.dart';
import '../bloc/get_photos/get_photo_event.dart';
import '../bloc/get_photos/get_photo_state.dart';

class ViewImage extends StatelessWidget {
  final PhotoModel photoModel;
  final bool isFavourite;

  const ViewImage(
      {Key? key, required this.photoModel, required this.isFavourite})
      : super(key: key);
  Future<void> downloadPhoto() async {
    final tmpdir = await getTemporaryDirectory();
    final path = '${tmpdir.path}/myfile.jpg';
    await Dio().download(photoModel.urlPhoto, path);
    await GallerySaver.saveImage(path, albumName: 'Photos');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<PhotoBloc>(),
      child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: photoModel.urlPhoto,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.cyan,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: primaryColor,
                          height: 50,
                          onPressed: () {
                            downloadPhoto().then((value) {
                              SnackBarMessage().snackBarMessageSuccess(
                                  context, 'Saved Successfully');
                            });
                          },
                          child: const Text(
                            'Save to Gallery',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      if (!isFavourite)
                        const SizedBox(
                          width: 10,
                        ),
                      if (!isFavourite)
                        Expanded(
                          child: MaterialButton(
                            color: primaryColor,
                            height: 50,
                            onPressed: () {
                              BlocProvider.of<PhotoBloc>(context)
                                  .add(CachedPhotoLocalEvent(photoModel));
                              SnackBarMessage().snackBarMessageSuccess(
                                  context, 'Added Successfully');
                            },
                            child: const Text(
                              'Add To Favourite',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
