import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video Game Review',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: MyAppHome(title: 'Video Game Review'),
    );
  }
}

class MyAppHome extends StatefulWidget {
  MyAppHome({key, this.title}) : super(key: key);

  final title;

  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
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
      body: const Center(),
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
