import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

String _hardMethod(_) {
  final stopwatch = Stopwatch()..start();
  print('!!! Worker_isolate is starting');
  List<int> list = [];
  for (var i = 0; i < 200000; i++) {
    if (i.isPrime) {
      list.add(i);
    }
    if (i == 200000 - 1) {
      print('!!! Hard operation is finished');
    }
  }
  print('!!! Worker_isolate is finished');
  print('Total time on worker_isolate = ${stopwatch.elapsedMilliseconds}');
  stopwatch.stop();
  return ('done!!!!');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isLoading = false;

  void _incrementCounter() async {
    setState(() {});
    isLoading = true;
    await Future.delayed(Duration(seconds: 1));
    String s = await compute(_hardMethod, '');

    setState(() {
      _counter++;
      isLoading = false;
    });
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
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

extension on int {
  bool get isPrime {
    if (this > 1) {
      for (int i = 2; i < this; i++) {
        if (this % i != 0) continue;
        return false;
      }
      return true;
    } else {
      return false;
    }
  }
}
