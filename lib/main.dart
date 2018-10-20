import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './models/movieModel.dart';
import './models/tmdb.dart';
import 'package:carousel_slider/carousel_slider.dart';

const baseUrl = "https://api.themoviedb.org/3/movie/";
const baseImageUrl = "https://image.tmdb.org/t/p/";
const apiKey = "03400e684b0d8c24d655190914d4aab8";

const nowPlayingUrl = "${baseUrl}now_playing?api_key=$apiKey";

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark(),
      home: MyMovieApp(),
    ));

class MyMovieApp extends StatefulWidget {
  @override
  _MyMovieApp createState() => new _MyMovieApp();
}

class _MyMovieApp extends State<MyMovieApp> {
  Movie nowPlayingMovies;

  @override
  void initState() {
    super.initState();
    _fetchNowPlayingMovies();
  }

  void _fetchNowPlayingMovies() async {
    var response = await http.get(nowPlayingUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      nowPlayingMovies = Movie.fromJson(decodeJson);
      print(decodeJson);
    });
  }

  Widget _buildCarouselSlider() => CarouselSlider(
        items: nowPlayingMovies.results
            .map((movieItem) =>
                Image.network("${baseImageUrl}w342${movieItem.posterPath}"))
            .toList(),
        autoPlay: false,
        height: 240.0,
        viewportFraction: 0.5,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Movie App',
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBookIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('NOW PLAYING',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              expandedHeight: 290.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Container(
                      child: Image.network(
                        "${baseImageUrl}w500/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
                        fit: BoxFit.cover,
                        width: 1000.0,
                        colorBlendMode: BlendMode.dstATop,
                        color: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Column(
                        children: nowPlayingMovies == null
                            ? <Widget>[
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                              ]
                            : <Widget>[_buildCarouselSlider()],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: Center(child: Text('Scroll me')),
      ),
    );
  }
}
