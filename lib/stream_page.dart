import 'package:flutter/material.dart';
import 'package:web_socket_channel/html.dart';
// import 'package:web_socket_channel/io.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = '';



  @override
  void initState() {
    startstream();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }

  startstream() async {
    var channel = HtmlWebSocketChannel.connect(Uri.parse('ws://127.0.0.1:8000/ws/some_url/'));

    channel.stream.listen((message) {
      print('message: $message sleep: ${message['sleep']}');
      if(mounted)setState(() {
        _counter = message;
      });

      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    });
  }
}
