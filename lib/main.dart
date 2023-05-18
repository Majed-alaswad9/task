import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task/core/dio_helper.dart';
import 'core/theme.dart';
import 'injection_container.dart' as di;
import 'package:task/features/photo/presentation/pages/photo_page.dart';
import 'package:task/temp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      home: PhotoPage(),
    );
  }
}
