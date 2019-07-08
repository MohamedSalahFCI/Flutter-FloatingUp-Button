import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller;

  static const List<IconData> icons = const [
    Icons.sms,
    Icons.mail,
    Icons.phone,
    Icons.favorite_border
  ];

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Speed Dial Example'),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                //child: new Icon(icons[index], color: foregroundColor),
                child: new Icon(icons[index], color: Colors.red),
                onPressed: () {
                  if (index == 0) {
                    Fluttertoast.showToast(msg: 'Message');
                  } else if (index == 1) {
                    Fluttertoast.showToast(msg: 'Message mob');
                  } else if (index == 2) {
                    Fluttertoast.showToast(msg: 'Dial');
                  } else if (index == 3) {
                    Fluttertoast.showToast(msg: 'fav');
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            new FloatingActionButton(
              backgroundColor: Colors.red,
              heroTag: null,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Transform(
                    transform: new Matrix4.rotationZ(
                        _controller.value * 0.5 * math.pi),
                    alignment: FractionalOffset.center,
                    child: new Icon(
                        _controller.isDismissed ? Icons.share : Icons.close),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                  Fluttertoast.showToast(msg: "Afth");
                } else {
                  _controller.reverse();
                  Fluttertoast.showToast(msg: "aafal");
                }
              },
            ),
          ),
      ),
      body: new ListView(
        children: <Widget>[
          Center(
            child: new Text("type your code here momo"),
          )
        ],
      ),
    );
  }
}
