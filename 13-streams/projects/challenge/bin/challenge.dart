// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await exercise();
  await challenge1();
  await challenge2();
}

/// The following code produces a stream that outputs an integer every second
/// and stops after the tenth time.
///
/// ```
/// Stream<int>.periodic(
///   Duration(seconds: 1),
///   (value) => value,
/// ).take(10);
/// ```
///
/// 1. Set the stream above to a variable named `myStream`.
/// 2. Use `await for` to print the value of the integer on each data event
///    coming from the stream.
Future<void> exercise() async {
  final myStream = Stream<int>.periodic(
    Duration(seconds: 1),
    (value) => value,
  ).take(10);
  await for (var number in myStream) {
    print(number);
  }
}

/// Challenge 1: Data Stream
///
/// The following code uses the `http` package to stream content from
/// the given URL:
///
/// ```
/// final url = Uri.parse('https://raywenderlich.com');
/// final client = http.Client();
/// final request = http.Request('GET', url);
/// final response = await client.send(request);
/// final stream = response.stream;
/// ```
///
/// Your challenge is to transform the stream from bytes to strings
/// and see how many bytes each data chunk is. Add error handling,
/// and when the stream is finished, close the client.
Future<void> challenge1() async {
  final url = Uri.parse('https://raywenderlich.com');
  final client = http.Client();
  try {
    final request = http.Request('GET', url);
    final response = await client.send(request);
    final stream = response.stream;
    await for (var data in stream.transform(utf8.decoder)) {
      print(data.length);
    }
  } on Exception catch (error) {
    print(error);
  } finally {
    client.close;
  }
}

/// Challenge 2: Heads or Tails?
///
/// Create a coin flipping service that provides a stream of 10 random coin
/// flips, each separated by 500 milliseconds. You use the service like so:
///
/// ```
/// final coinFlipper = CoinFlippingService();
///
/// coinFlipper.onFlip.listen((coin) {
///   print(coin);
/// });
///
/// coinFlipper.start();
/// ```
///
/// `onFlip` is the name of the stream.
Future<void> challenge2() async {
  final coinFlipper = CoinFlippingService();

  coinFlipper.onFlip.listen((coin) {
    print(coin);
  });

  coinFlipper.start();
}

enum Coin { heads, tails }

class CoinFlippingService {
  final _controller = StreamController<Coin>();

  Stream<Coin> get onFlip => _controller.stream;

  Future<void> start() async {
    for (int i = 0; i < 10; i++) {
      Future.delayed(
        Duration(milliseconds: 500 * i),
        () => _controller.add(Random().nextBool() ? Coin.heads : Coin.tails),
      );
    }
  }

  void dispose() => _controller.close();
}
