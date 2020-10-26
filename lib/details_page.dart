import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/movie_response.dart';

class DetailsPage extends StatelessWidget {
  Response _response;

  DetailsPage(this._response);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "title",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white70),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(_response.title),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: MovieDetails(_response),
      ),
    );
  }
}

class MovieDetails extends StatefulWidget {
  Response _response;

  MovieDetails(this._response);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    IconData iconData;

    return ListView(
      children: <Widget>[
        new Image.network(
            "http://image.tmdb.org/t/p/w500/${widget._response.back}"),
        Row(
          children: <Widget>[
            // this is for column
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.orangeAccent, size: 30),
                  Text(widget._response.rating,
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            // this is for likes
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(iconData,
                        size: 30, color: Colors.redAccent),
                    Text("True", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                onTap: () {
                  setState(() {});
                },
              ),
            ),
            // this is for views
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.remove_red_eye, size: 30, color: Colors.white70),
                  Text(widget._response.views,
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(widget._response.overall,
                style: TextStyle(color: Colors.white70)),
          ),
        ),
      ],
    );
  }
}
