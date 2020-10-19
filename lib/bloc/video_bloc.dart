import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_youtube/api/api.dart';
import 'package:bloc_youtube/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<Video> videos;

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  void _search(String search) async {
    if (search != null) {
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
