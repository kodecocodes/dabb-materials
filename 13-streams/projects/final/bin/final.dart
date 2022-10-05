// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  await readAsString();
  readFromStream();
  await readFromStreamAsynchronousForLoop();
  errorHandlingUsingCallbacks();
  await errorHandlingUsingTryCatch();
  cancellingStreams();
  transformingStreams();
  creatingStreamsFromScratch();
}

Future<void> readAsString() async {
  final file = File('assets/text.txt');
  final contents = await file.readAsString();
  print(contents);
}

void readFromStream() {
  final file = File('assets/text_long.txt');
  final stream = file.openRead();
  stream.listen(
    (data) {
      print(data.length);
    },
  );
}

Future<void> readFromStreamAsynchronousForLoop() async {
  final file = File('assets/text_long.txt');
  final stream = file.openRead();
  await for (var data in stream) {
    print(data.length);
  }
}

void errorHandlingUsingCallbacks() {
  final file = File('assets/text_long.txt');
  final stream = file.openRead();
  stream.listen(
    (data) {
      print(data.length);
    },
    onError: (Object error) {
      print(error);
    },
    onDone: () {
      print('All finished');
    },
  );
}

Future<void> errorHandlingUsingTryCatch() async {
  try {
    final file = File('assets/text_long.txt');
    final stream = file.openRead();
    await for (var data in stream) {
      print(data.length);
    }
  } on Exception catch (error) {
    print(error);
  } finally {
    print('All finished');
  }
}

void cancellingStreams() {
  final file = File('assets/text_long.txt');
  final stream = file.openRead();
  StreamSubscription<List<int>>? subscription;
  subscription = stream.listen(
    (data) {
      print(data.length);
      subscription?.cancel();
    },
    cancelOnError: true,
    onDone: () {
      print('All finished');
    },
  );
}

void transformingStreams() {
  viewingBytes();
  decodingBytes();
}

void viewingBytes() {
  final file = File('assets/text.txt');
  final stream = file.openRead();
  stream.listen(
    (data) {
      print(data);
    },
  );
}

Future<void> decodingBytes() async {
  final file = File('assets/text.txt');
  final byteStream = file.openRead();
  final stringStream = byteStream.transform(utf8.decoder);
  await for (var data in stringStream) {
    print(data);
  }
}

void creatingStreamsFromScratch() {
  usingConstructors();
  reviewingSynchronousGenerators();
  usingAsynchronousGenerators();
  usingStreamControllers();
}

void usingConstructors() {
  final first = Future(() => 'Row');
  final second = Future(() => 'row');
  final third = Future(() => 'row');
  final fourth = Future.delayed(
    Duration(milliseconds: 300),
    () => 'your boat',
  );

  final stream = Stream<String>.fromFutures([
    first,
    second,
    third,
    fourth,
  ]);

  stream.listen((data) {
    print(data);
  });
}

void reviewingSynchronousGenerators() {
  final squares = hundredSquares();
  for (final square in squares) {
    print(square);
  }
}

Iterable<int> hundredSquares() sync* {
  for (int i = 1; i <= 100; i++) {
    yield i * i;
  }
}

void usingAsynchronousGenerators() {
  final stream = consciousness();

  stream.listen((data) {
    print(data);
  });
}

Stream<String> consciousness() async* {
  final data = ['con', 'scious', 'ness'];
  for (final part in data) {
    await Future<void>.delayed(Duration(milliseconds: 500));
    yield part;
  }
}

void usingStreamControllers() {
  final controller = StreamController<String>();
  final stream = controller.stream;
  final sink = controller.sink;

  stream.listen(
    (value) => print(value),
    onError: (Object error) => print(error),
    onDone: () => print('Sink closed'),
  );

  sink.add('grape');
  sink.add('grape');
  sink.add('grape');
  sink.addError(Exception('cherry'));
  sink.add('grape');
  sink.close();
}
