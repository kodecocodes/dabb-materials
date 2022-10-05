// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await futureType();
  await usingCallbacks();
  await usingAsyncAwait();
  await usingAsyncAwaitWithErrorHandling();
  await asynchronousNetworkRequest();
  await creatingFutureFromScratch();
}

Future<void> futureType() async {
  final numberOfAtoms = await countTheAtoms();
  print(numberOfAtoms);

  final myFuture = Future<int>.delayed(
    Duration(seconds: 1),
    () => 42,
  );
  print(myFuture);
}

Future<int> countTheAtoms() async {
  return 9200000000000000000;
}

Future<void> usingCallbacks() async {
  print('Before the future');

  final myFuture = Future<int>.delayed(
    Duration(seconds: 1),
    () => 42,
  )
      .then(
        (value) => print('Value: $value'),
      )
      .catchError(
        (Object error) => print('Error: $error'),
      )
      .whenComplete(
        () => print('Future is complete'),
      );

  print('After the future');
}

Future<void> usingAsyncAwait() async {
  print('Before the future');

  final value = await Future<int>.delayed(
    Duration(seconds: 1),
    () => 42,
  );
  print('Value: $value');

  print('After the future');
}

Future<void> usingAsyncAwaitWithErrorHandling() async {
  print('Before the future');

  try {
    final value = await Future<int>.delayed(
      Duration(seconds: 1),
      () => 42,
    );
    print('Value: $value');
  } catch (error) {
    print(error);
  } finally {
    print('Future is complete');
  }

  print('After the future');
}

Future<void> asynchronousNetworkRequest() async {
  try {
    final url = 'https://jsonplaceholder.typicode.com/todos/1';
    // final url = 'https://jsonplaceholder.typicode.com/todos/pink-elephants';
    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw HttpException('$statusCode');
    }
    final jsonString = response.body;
    dynamic jsonMap = jsonDecode(jsonString);
    final todo = Todo.fromJson(jsonMap);
    print(todo);
  } on SocketException catch (error) {
    print(error);
  } on HttpException catch (error) {
    print(error);
  } on FormatException catch (error) {
    print(error);
  }
}

class Todo {
  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> jsonMap) {
    return Todo(
      userId: jsonMap['userId'] as int,
      id: jsonMap['id'] as int,
      title: jsonMap['title'] as String,
      completed: jsonMap['completed'] as bool,
    );
  }

  final int userId;
  final int id;
  final String title;
  final bool completed;

  @override
  String toString() {
    return 'userId: $userId\n'
        'id: $id\n'
        'title: $title\n'
        'completed: $completed';
  }
}

Future<void> creatingFutureFromScratch() async {
  final web = FakeWebServer();
  try {
    final city = 'Portland';
    final degrees = await web.fetchTemperature(city);
    print("It's $degrees degrees in $city.");
  } on ArgumentError catch (error) {
    print(error);
  }
}

abstract class DataRepository {
  Future<double> fetchTemperature(String city);
}

class FakeWebServer implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future(() => 42.0);
  }
}

class FakeWebServerValueNamedConstructor implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.value(42.0);
  }
}

class FakeWebServerErrorNamedConstructor implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.error(ArgumentError("$city doesn't exist."));
  }
}

class FakeWebServerDelayedValue implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.delayed(
      Duration(seconds: 2),
      () => 42.0,
    );
  }
}

class FakeWebServerDelayedError implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.delayed(
      Duration(seconds: 2),
      () => throw ArgumentError('City does not exist.'),
    );
  }
}

class FakeWebServerAsyncMethod implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) async {
    return 42.0;
  }
}

class FakeWebServerCompleter implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    final completer = Completer<double>();
    if (city == 'Portland') {
      completer.complete(42.0);
    } else {
      completer.completeError(ArgumentError("City doesn't exist."));
    }
    return completer.future;
  }
}
