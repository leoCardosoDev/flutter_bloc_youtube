import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_youtube/bloc/favorite_bloc.dart';
import 'package:bloc_youtube/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'bloc/video_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
