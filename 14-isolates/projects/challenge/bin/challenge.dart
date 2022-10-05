// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

import 'dart:convert';
import 'dart:isolate';

Future<void> main() async {
  await challenge1();
  await challenge2();
}

/// Challenge 1: Fibonacci From Afar
///
/// Calculate the nth Fibonacci number. The Fibonacci sequence starts with 1,
/// then 1 again, and then all subsequent numbers in the sequence are simply
/// the previous two values in the sequence added together (1, 1, 2, 3, 5, 8...).
///
/// If you worked through the challenges in _Dart Apprentice: Fundamentals_,
/// Chapter 6, "Loops", you've already solved this one. Repeat the challenge,
/// but run the code in a separate isolate. Pass the value of _n_ to the new
/// isolate as an argument, and send the result back to the main isolate.
Future<void> challenge1() async {
  final receivePort = ReceivePort();
  final n = 10;
  final arguments = {
    'sendPort': receivePort.sendPort,
    'n': n,
  };

  await Isolate.spawn<Map<String, Object>>(
    fibonacci,
    arguments,
  );

  final message = await receivePort.first as int;
  print('Fibonacci number $n is $message.');
}

void fibonacci(Map<String, Object> arguments) {
  final sendPort = arguments['sendPort'] as SendPort;
  final n = arguments['n'] as int;
  var current = 1;
  var previous = 1;
  var done = 2;
  while (done < n) {
    final next = current + previous;
    previous = current;
    current = next;
    done += 1;
  }
  Isolate.exit(sendPort, current);
}

/// Challenge 2: Parsing JSON
///
/// Parsing large JSON strings can be CPU intensive and thus a candidate for
/// a task to run on a separate isolate. The following JSON string isn't
/// particularly large, but convert it to a map on a separate isolate:
///
/// ```
/// const jsonString = '''
/// {
///   "language": "Dart",
///   "feeling": "love it",
///   "level": "intermediate"
/// }
/// ''';
/// ```
Future<void> challenge2() async {
  final receivePort = ReceivePort();
  await Isolate.spawn<SendPort>(
    _entryPoint,
    receivePort.sendPort,
  );

  final map = await receivePort.first as Map<String, dynamic>;
  print(map);
}

const jsonString = '''
{
  "language": "Dart",
  "feeling": "love it",
  "level": "intermediate"
}
''';

void _entryPoint(SendPort sendPort) {
  dynamic jsonMap = jsonDecode(jsonString);
  Isolate.exit(sendPort, jsonMap);
}
