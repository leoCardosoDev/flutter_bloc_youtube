import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_youtube/bloc/favorite_bloc.dart';
import 'package:bloc_youtube/bloc/video_bloc.dart';
import 'package:bloc_youtube/delegates/data_search.dart';
import 'package:bloc_youtube/models/video.dart';
import 'package:bloc_youtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocVideos = BlocProvider.of<VideosBloc>(context);
    final blocFavorite = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset('assets/images/yt_logo_rgb_dark.png'),
        ),
        elevation: 4,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream: blocFavorite.outFavorites,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('${snapshot.data.length}');
                  } else {
                    return Container();
                  }
                }),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String resultSearch =
                  await showSearch(context: context, delegate: DataSearch());
              if (resultSearch != null) blocVideos.inSearch.add(resultSearch);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: blocVideos.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(
                    video: snapshot.data[index],
                  );
                } else if (index > 1) {
                  blocVideos.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
