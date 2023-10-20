import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ideas/screens/animations.dart';
import 'package:new_ideas/screens/catalog.dart';
import 'package:new_ideas/screens/webpage.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Favourites'),
      ),
      body: Column(children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Text('Catalog App'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WebViewExample()));
            },
            child: Text('Webview App'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AnimationPage()));
            },
            child: Text('Animations App'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: () {}, child: Text('data')),
        CupertinoButton(
            minSize: 1.0,
            color: Colors.greenAccent,
            // color: Colors.amber,
            child: Text('kMi'),
            onPressed: () {})
      ]),
    );
  }
}
