//import 'dart:async';
//import 'dart:convert';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:movie_app/drawer_page/drawer_1';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(),
//      home: DelayedList(),
//    );
//  }
//}
//
//class DelayedList extends StatefulWidget {
//  @override
//  _DelayedListState createState() => _DelayedListState();
//}
//
//class _DelayedListState extends State<DelayedList> {
//  bool isLoading = true;
//
//  @override
//  Widget build(BuildContext context) {
//    Timer timer = Timer(Duration(seconds: 7), () {
//      setState(() {
//        isLoading = false;
//      });
//    });
//    return isLoading
//        ? Center(
//            child: CircularProgressIndicator(),
//          )
//        : DataList(timer);
//  }
//}
//
//class DataList extends StatelessWidget {
//  final Timer timer;
//
//  DataList(this.timer);
//
//  @override
//  Widget build(BuildContext context) {
//    timer.cancel();
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.black,
//        title: Text("Movie App"),
//        centerTitle: true,
//      ),
//      drawer: _fetchDrawer(context),
//      body: ChoiceCard(),
//    );
//  }
//
//  // fetch drawer
//  Drawer _fetchDrawer(BuildContext context) {
//    String profilePic =
//        "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg";
//    return Drawer(
//      child: new ListView(
//        children: <Widget>[
//          new GestureDetector(
//            child: new CircleAvatar(
//              maxRadius: 50.0,
//              minRadius: 50.0,
//              backgroundImage: new NetworkImage(profilePic),
//            ),
//          ),
//          new ListTile(
//              title: new Text("Popular Movies"),
//              trailing: new Icon(Icons.arrow_right),
//              onTap: () {}),
//          new ListTile(
//              title: new Text("Top Rated Movies"),
//              trailing: new Icon(Icons.arrow_right),
//              onTap: () {
//                // refresh("top_rated");
//              }),
//          new ListTile(
//              title: new Text("Cinema Movies"),
//              trailing: new Icon(Icons.arrow_right),
//              onTap: () {
//                // refresh("now_playing");
//              }),
//          new ListTile(
//              title: new Text("New Coming Movies"),
//              trailing: new Icon(Icons.arrow_right),
//              onTap: () {}),
//        ],
//      ),
//    );
//  }
//}
//
//class ChoiceCard extends StatefulWidget {
//  const ChoiceCard({Key key}) : super(key: key);
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<ChoiceCard> {
//  List data;
//
//  void refresh(String key) {
//    setState(() {
//      this.getSources(key);
//    });
//  }
//
//  Future<String> getSources(String query) async {
//    final String sources =
//        "http://api.themoviedb.org/3/movie/$query?api_key=d0ddb12fac94408fbd00aad0226f55b4";
//
//    var response = await http
//        .get(Uri.encodeFull(sources), headers: {"Accept": "Application/json"});
//
//    print(response.body);
//
//    setState(() {
//      var convertDataToJson = json.decode(response.body);
//      data = convertDataToJson['results'];
//    });
//    return 'success';
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    this.getSources("popular");
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return GridView.builder(
//      gridDelegate:
//          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//      itemCount: data == null ? 0 : data.length,
//      itemBuilder: (BuildContext context, int index) {
//        String image;
//        image = "http://image.tmdb.org/t/p/w500/" + data[index]["poster_path"];
//        return Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: GestureDetector(
//              child: Card(
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      child: Expanded(
//                        child: Image.network(
//                          image,
//                          width: 150,
//                          fit: BoxFit.cover,
//                        ),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: Text(
//                        data[index]['title'],
//                        style: TextStyle(
//                            fontSize: 10.0, fontWeight: FontWeight.normal),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              onTap: () {
//                Navigator.of(context).push(new MaterialPageRoute(
//                    builder: (BuildContext context) => new HomePage()));
//              }),
//        );
//      },
//    );
//  }
//}
