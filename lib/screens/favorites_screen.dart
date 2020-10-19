import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_youtube/bloc/favorite_bloc.dart';
import 'package:bloc_youtube/models/video.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, Video>>(
        stream: favoriteBloc.outFavorites,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values
                .map((value) => InkWell(
                      onTap: () {},
                      onLongPress: () {
                        favoriteBloc.toggleFavorite(value);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              child: Image.network(value.thumb),
                            ),
                            Expanded(child: Text(value.title)),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
