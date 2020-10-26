import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/details_page.dart';
import 'package:movie_app/movie_response.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;

  bool isLoading = true;

  void refresh(String key) {
    setState(() {
      this.getSources(key);
    });
  }

  Future<String> getSources(String query) async {
    print("sources called");
    final String sources =
        "http://api.themoviedb.org/3/movie/$query?api_key=21563b5c7baa733f9cd84fc9e3380d81";

    var response = await http
        .get(Uri.encodeFull(sources), headers: {"Accept": "Application/json"});

    print(response.body);

    setState(() {
      isLoading = false;

      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.getSources("popular");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Movie App"),
        centerTitle: true,
      ),
      drawer: _fetchDrawer(context),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _fetchbody(),
    );
  }

  // fetch drawer
  Drawer _fetchDrawer(BuildContext context) {
    String profilePic =
        "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg";
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: new CircleAvatar(
                maxRadius: 100.0,
                minRadius: 100.0,
                backgroundImage: new NetworkImage(profilePic),
              ),
            ),
          ),
          new ListTile(
              title: new Text("Popular Movies"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                refresh("popular");
                Navigator.of(context).pop();
              }),
          new ListTile(
              title: new Text("Top Rated Movies"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                refresh("top_rated");
                Navigator.of(context).pop();
              }),
          new ListTile(
              title: new Text("Cinema Movies"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                refresh("now_playing");
                Navigator.of(context).pop();
              }),
          new ListTile(
              title: new Text("Upcoming Movies"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                refresh("upcoming");
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  GridView _fetchbody() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        String image;
        image = "http://image.tmdb.org/t/p/w500/" + data[index]["poster_path"];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: Image.network(
                          image,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        data[index]['title'],
                        style: TextStyle(
                            fontSize: 10.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Response response = new Response.withId(
                  data[index]["id"].toString(),
                  data[index]["title"].toString(),
                  data[index]["poster_path"].toString(),
                  data[index]["backdrop_path"].toString(),
                  data[index]["vote_average"].toString(),
                  data[index]["popularity"].toString(),
                  data[index]["overview"].toString(),
                );

                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new DetailsPage(response)));
              }),
        );
      },
    );
  }
}
