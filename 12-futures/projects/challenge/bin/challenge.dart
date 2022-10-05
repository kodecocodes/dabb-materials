// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await exercise();
  await challenge1();
  await challenge2();
  await challenge3();
}

/// Exercise
///
/// 1. Use the `Future.delayed` constructor to provide a string after two
///    seconds that says, "I am from the future."
/// 2. Create a `String` variable named `message` that awaits the future to
///    complete with a value.
/// 3. Surround your code with a `try-catch` block.
Future<void> exercise() async {
  print('Starting exercise...');
  try {
    final message = await Future<String>.delayed(
      Duration(seconds: 2),
      () => 'I am from the future.',
    );
    print(message);
  } catch (error) {
    print(error);
  }
}

/// Challenge 1: Spotty Internet
///
/// Implement `FakeWebServer.fetchTemperature` so it completes sometimes
/// with a value and sometimes with an error. Use `Random` to help you.
/// Use `Random` to help you.
Future<void> challenge1() async {
  final web = FakeWebServer();
  await checkTemperature(web);
  await checkTemperature(web);
  await checkTemperature(web);
  await checkTemperature(web);
}

Future<void> checkTemperature(DataRepository webServer) async {
  try {
    final city = 'Portland';
    final degrees = await webServer.fetchTemperature(city);
    print("It's ${degrees.toInt()} degrees in $city.");
  } on HttpException catch (error) {
    print(error);
  }
}

abstract class DataRepository {
  Future<double> fetchTemperature(String city);
}

class FakeWebServer implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    // import dart:math
    final random = Random();
    final isError = random.nextBool();
    if (isError) {
      return Future.error(HttpException("Couldn't reach server."));
    } else {
      final temp = random.nextDouble() * 50;
      return Future.value(temp);
    }
  }
}

/// Challenge 2: What's the Temperature?
///
/// Use a real web api to get the temperature and implement the
/// `DataRepository` interface from the lesson.
///
/// [Free Code Camp](https://www.freecodecamp.org/) has a weather API that
/// takes the following form:
///
/// https://fcc-weather-api.glitch.me/api/current?lat=45.5&lon=-122.7
///
///
/// You can change the numbers after `lat` and `lon` to specify latitude and
/// longitude for the weather.
///
/// Complete the following steps to find the weather:
///
/// 1. Convert the URL above to a Dart `Uri` object.
/// 2. Use the http package to make a GET request.
///    This will give you a `Response` object.
/// 3. Use the `response.body` to get the JSON string.
/// 4. Decode the JSON string into a Dart map.
/// 5. Print the map and look for the temperature.
/// 6. Extract the temperature and the city name from the map.
/// 7. Print the weather report as a sentence.
/// 8. Add error handling.
Future<void> challenge2() async {
  const base = 'https://fcc-weather-api.glitch.me/api/current';
  const latitude = 45.5;
  const longitude = -122.7;
  final url = Uri.parse('$base?lat=$latitude&lon=$longitude');
  try {
    final response = await http.get(url);
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw HttpException('$statusCode');
    }
    final jsonString = response.body;
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    print(jsonMap);
    final temperature = jsonMap['main']['temp'] as double;
    final city = jsonMap['name'] as String;
    print("It's $temperature degrees in $city.");
  } on SocketException catch (error) {
    print(error);
  } on HttpException catch (error) {
    print(error);
  } on FormatException catch (error) {
    print(error);
  }
}

/// Challenge 3: Care to Make a Comment?
///
/// The following link returns a JSON list of comments:
///
/// https://jsonplaceholder.typicode.com/comments
///
/// Create a `Comment` data class and convert the raw JSON to a Dart list
/// of type `List<Comment>`.
Future<void> challenge3() async {
  // import dart:convert, dart:io and package:http
  final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
  final commentList = <Comment>[];
  try {
    final response = await http.get(url);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final rawJsonString = response.body;
      dynamic jsonList = jsonDecode(rawJsonString);
      for (var element in jsonList) {
        final comment = Comment.fromJson(element);
        commentList.add(comment);
      }
    } else {
      throw HttpException('$statusCode');
    }
  } on SocketException catch (error) {
    print(error);
  } on HttpException catch (error) {
    print(error);
  } on FormatException catch (error) {
    print(error);
  }

  print('Comment list length: ${commentList.length}');
}

class Comment {
  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> jsonMap) {
    return Comment(
      postId: jsonMap['postId'] as int,
      id: jsonMap['id'] as int,
      name: jsonMap['name'] as String,
      email: jsonMap['email'] as String,
      body: jsonMap['body'] as String,
    );
  }

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  @override
  String toString() {
    return '$postId, $id, $name, $email, $body';
  }
}
