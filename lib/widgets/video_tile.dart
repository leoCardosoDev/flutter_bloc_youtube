import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_youtube/bloc/favorite_bloc.dart';
import 'package:bloc_youtube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile({this.video});

  @override
  Widget build(BuildContext context) {
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.channel,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                  stream: favoriteBloc.outFavorites,
                  initialData: {},
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: Icon(snapshot.data.containsKey(video.id)
                            ? Icons.favorite
                            : Icons.favorite_border_outlined),
                        onPressed: () {
                          favoriteBloc.toggleFavorite(video);
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
