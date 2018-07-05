import 'package:feature_dicovery/layout.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Feature Dicovery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        leading: FeaturedOverlay(
          showOverlay: false,
          icon: Icons.menu,
          color: Colors.green,
          title: 'This is the title',
          description: 'This is the description',
          child: new IconButton(
            icon: new Icon(
              Icons.menu,
            ),
            onPressed: () {
              // TODO:
            },
          ),
        ),
        title: new Text('Feature Discovery'),
        actions: <Widget>[
          FeaturedOverlay(
            showOverlay: false,
            icon: Icons.search,
            color: Colors.green,
            title: 'This is the title',
            description: 'This is the description',
            child: new IconButton(
              icon: new Icon(
                Icons.search,
              ),
              onPressed: () {
                // TODO:
              },
            ),
          ),
        ],
      ),
      body: new Content(),
      floatingActionButton: FeaturedOverlay(
        showOverlay: true,
        icon: Icons.add,
        color: Colors.blue,
        title: 'This is the title',
        description: 'This is the description',
        child: new FloatingActionButton(
          onPressed: () => {},
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => new _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Image.network(
              'https://www.balboaisland.com/wp-content/uploads/Starbucks-Balboa-Island-01.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
            ),
            new Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        'Starbucks Coffee',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    new Text(
                      'Coffee Shop',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )),
            new Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: new RaisedButton(
                  child: new Text('Do Feature Discovery'),
                  onPressed: () {},
                )),
          ],
        ),
        new Positioned(
            top: 200.0,
            right: 0.0,
            child: new FractionalTranslation(
              translation: const Offset(-0.5, -0.5),
              child: FeaturedOverlay(
                showOverlay: false,
                icon: Icons.drive_eta,
                color: Colors.blue,
                title: 'This is the title',
                description: 'This is the description',
                child: new FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  child: new Icon(
                    Icons.drive_eta,
                  ),
                  onPressed: () {
                    // TODO:
                  },
                ),
              ),
            )),
      ],
    );
  }
}

class FeaturedOverlay extends StatefulWidget {
  final bool showOverlay;
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final Widget child;

  FeaturedOverlay(
      {this.showOverlay,
      this.icon,
      this.color,
      this.title,
      this.description,
      this.child});

  @override
  _FeaturedOverlayState createState() => new _FeaturedOverlayState();
}

class _FeaturedOverlayState extends State<FeaturedOverlay> {
  @override
  Widget build(BuildContext context) {
    return new AnchoredOverlay(
      showOverlay: widget.showOverlay,
      builder: (BuildContext context, Offset anchor) {
        final backgroundRadius = MediaQuery.of(context).size.width;
        final touchTargetRadius = 44.0;
        final orientation = _getContentOrientation(anchor);
        final contentOffsetMultiplyer = orientation == FeaturedContentOrientation.below ? 1.0 : -1.0;
        final contentY = anchor.dy + contentOffsetMultiplyer * (touchTargetRadius + 20);
        return new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new CenterAbout(
                position: anchor,
                child: Container(
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle, color: widget.color),
                  width: 2 * backgroundRadius,
                  height: 2 * backgroundRadius,
                )),
            new Positioned(
              top: contentY,
              child: new Material(
                color: Colors.transparent,
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: new Text(
                          widget.title,
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      new Text(
                        widget.description,
                        style: new TextStyle(
                            fontSize: 15.0,
                            color: Colors.white.withOpacity(0.98)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new CenterAbout(
              position: anchor,
              child: Container(
                width: 2 * touchTargetRadius,
                height: 2 * touchTargetRadius,
                child: new RawMaterialButton(
                  shape: new CircleBorder(),
                  fillColor: Colors.white,
                  child: new Icon(widget.icon, color: widget.color),
                  onPressed: () {},
                ),
              ),
            )
          ],
        );
      },
      child: widget.child,
    );
  }

  FeaturedContentOrientation _getContentOrientation(Offset anchor) {

  }
}

enum FeaturedContentOrientation { above, below }
