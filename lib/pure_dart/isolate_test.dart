// ignore_for_file: avoid_print

import 'dart:isolate';

/// Imitation of hard operation
void _hardMethod(_) {
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
}

void main() async {
  final stopwatch = Stopwatch()..start();
  print('Before Hard operation');
  Isolate.spawn(_hardMethod, '');

  print('After launch worker_isolate');
  print('Total time in main_isolate = ${stopwatch.elapsedMilliseconds}');

  /// Added duration for main_isolate so worker_isolate  could  finish before main_isolate is closed
  Future.delayed(const Duration(seconds: 7));
  stopwatch.stop();
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
