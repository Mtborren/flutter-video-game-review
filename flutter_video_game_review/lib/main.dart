import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

Future<List<Game>> fetchGames() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/'));

  if (response.statusCode == 200) {
    var videogames = json.decode(response.body);
    return videogames.map<Game>((v) => Game.fromJson(v)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class Game {
  final int id;
  final String title;
  final String description;
  final int releaseYear;
  final int rating;
  final String review;

  const Game({
    required this.id,
    required this.title,
    required this.description,
    required this.releaseYear,
    required this.rating,
    required this.review,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      releaseYear: json['release_year'],
      rating: json['rating'],
      review: json['review'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video Game Review',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: MyAppHome(title: 'Video Game Review'),
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({key, this.title}) : super(key: key);

  final title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppHome> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Score'), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {
              showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) => openTopDrawer(),
              );
            })
      ]),
      body: Center(
          child: FutureBuilder<List<Game>>(
              future: fetchGames(),
              builder: (context, snapshot) {
                var result;
                if (snapshot.hasData && snapshot.data != null) {
                  List<Game> games = snapshot.data!;
                  result = Container(
                      child: ListView.builder(
                          itemCount: games.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            var gameData = games[index];
                            return GameRow(gameData: gameData);
                          }));
                  // return Center(child: CircularProgressIndicator());
                } else {
                  result = Text('${snapshot.error}');
                }
                return result;
              })),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              padding: EdgeInsets.all(20),
              onPressed: () {
                Fluttertoast.showToast(msg: 'This will be the home link');
              }),
          IconButton(
              icon: Icon(Icons.insights),
              padding: EdgeInsets.all(20),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: 'This will be the highest rated link');
              }),
          IconButton(
              icon: Icon(Icons.gamepad_outlined),
              padding: EdgeInsets.all(20),
              onPressed: () {
                Fluttertoast.showToast(msg: 'This will be an add review link');
              }),
        ],
      )),
    );
  }

  Widget openTopDrawer() {
    return Drawer(
        child: Column(children: const <Widget>[
      ListTile(
        leading: Icon(Icons.account_circle_outlined),
        title: Text('Sign In'),
      ),
      ListTile(
        leading: Icon(Icons.mode_edit),
        title: Text('Create Account'),
      )
    ]));
  }
}

class GameRow extends StatelessWidget {
  const GameRow({
    super.key,
    required this.gameData,
  });

  final Game gameData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(gameData.title),
          Spacer(),
          Text(gameData.rating.toString()),
        ],
      ),
    );
  }
}
