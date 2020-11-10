import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class Page with ChangeNotifier {
  String _name = "default name";

  String get name => _name;

  Page() {
    print("created an instance");
  }

  void setId(String name) {
    this._name = name;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Page>(
      create: (_) => Page(),
      lazy: true,
      builder: (context, widget) => MaterialApp(
        title: 'lazy providers',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {'/page_screen': (_) => PageScreen()},
        home: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text(
              'testing lazy loaded providers',
            ),
          ),
          floatingActionButton: Builder(
            builder: (ctx) => FloatingActionButton(
              onPressed: () => Navigator.pushNamed(ctx, '/page_screen'),
              child: Text('push'),
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}

class PageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called build");
    final pageProvider = Provider.of<Page>(context, listen: true);
    final name = pageProvider.name;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            RaisedButton(
              child: Text("press to name page"),
              onPressed: () => pageProvider.setId("new page"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/page_screen'),
        child: Text('push'),
      ),
    );
  }
}
