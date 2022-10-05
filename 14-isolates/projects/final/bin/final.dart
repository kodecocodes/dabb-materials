// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

import 'dart:io';
import 'dart:isolate';

Future<void> main() async {
  appStoppingSynchronousCode();
  await appStoppingAsynchronousCode();
  await oneWayIsolateCommunication();
  await sendingMultipleMessages();
  await passingMultipleArgumentsAsList();
  await passingMultipleArgumentsAsMap();
  await twoWayCommunication();
}

void appStoppingSynchronousCode() {
  String playHideAndSeekTheLongVersion() {
    var counting = 0;
    for (var i = 1; i <= 10000000000; i++) {
      counting = i;
    }
    return '$counting! Ready or not, here I come!';
  }

  print("OK, I'm counting...");
  print(playHideAndSeekTheLongVersion());
}

Future<void> appStoppingAsynchronousCode() async {
  Future<String> playHideAndSeekTheLongVersion() async {
    var counting = 0;
    await Future(() {
      for (var i = 1; i <= 1000000000; i++) {
        counting = i;
      }
    });
    return '$counting! Ready or not, here I come!';
  }

  print("OK, I'm counting...");
  print(await playHideAndSeekTheLongVersion());
}

Future<void> oneWayIsolateCommunication() async {
  final receivePort = ReceivePort();

  await Isolate.spawn<SendPort>(
    playHideAndSeekTheLongVersion1,
    receivePort.sendPort,
  );

  final message = await receivePort.first as String;
  print(message);
}

void playHideAndSeekTheLongVersion1(SendPort sendPort) {
  var counting = 0;
  for (var i = 1; i <= 1000000000; i++) {
    counting = i;
  }
  final message = '$counting! Ready or not, here I come!';
  // 2
  Isolate.exit(sendPort, message);
}

Future<void> sendingMultipleMessages() async {
  final receivePort = ReceivePort();

  final isolate = await Isolate.spawn<SendPort>(
    playHideAndSeekTheLongVersion2,
    receivePort.sendPort,
  );

  receivePort.listen((Object? message) {
    if (message is String) {
      print(message);
    } else if (message == null) {
      receivePort.close();
      isolate.kill();
    }
  });
}

void playHideAndSeekTheLongVersion2(SendPort sendPort) {
  sendPort.send("OK, I'm counting...");

  var counting = 0;
  for (var i = 1; i <= 1000000000; i++) {
    counting = i;
  }

  sendPort.send('$counting! Ready or not, here I come!');
  sendPort.send(null);
}

Future<void> passingMultipleArgumentsAsList() async {
  final receivePort = ReceivePort();

  final isolate = await Isolate.spawn<List<Object>>(
    playHideAndSeekTheLongVersion3,
    [receivePort.sendPort, 999999999],
  );

  receivePort.listen((Object? message) {
    if (message is String) {
      print(message);
    } else if (message == null) {
      receivePort.close();
      isolate.kill();
    }
  });
}

void playHideAndSeekTheLongVersion3(List<Object> arguments) {
  final sendPort = arguments[0] as SendPort;
  final countTo = arguments[1] as int;

  sendPort.send("OK, I'm counting...");

  var counting = 0;
  for (var i = 1; i <= countTo; i++) {
    counting = i;
  }

  sendPort.send('$counting! Ready or not, here I come!');
  sendPort.send(null);
}

Future<void> passingMultipleArgumentsAsMap() async {
  final receivePort = ReceivePort();

  final isolate = await Isolate.spawn<Map<String, Object>>(
    playHideAndSeekTheLongVersion4,
    {
      'sendPort': receivePort.sendPort,
      'countTo': 999999999,
    },
  );

  receivePort.listen((Object? message) {
    if (message is String) {
      print(message);
    } else if (message == null) {
      receivePort.close();
      isolate.kill();
    }
  });
}

void playHideAndSeekTheLongVersion4(Map<String, Object> arguments) {
  final sendPort = arguments['sendPort'] as SendPort;
  final countTo = arguments['countTo'] as int;

  sendPort.send("OK, I'm counting...");

  var counting = 0;
  for (var i = 1; i <= countTo; i++) {
    counting = i;
  }

  sendPort.send('$counting! Ready or not, here I come!');
  sendPort.send(null);
}

Future<void> twoWayCommunication() async {
  final earth = Earth();
  await earth.contactMars();
}

class Work {
  Future<int> doSomething() async {
    print('doing some work...');
    sleep(Duration(seconds: 1));
    return 42;
  }

  Future<int> doSomethingElse() async {
    print('doing some other work...');
    sleep(Duration(seconds: 1));
    return 24;
  }
}

Future<void> _entryPoint(SendPort sendToEarthPort) async {
  final receiveOnMarsPort = ReceivePort();
  sendToEarthPort.send(receiveOnMarsPort.sendPort);

  final work = Work();

  receiveOnMarsPort.listen((Object? messageFromEarth) async {
    await Future<void>.delayed(Duration(seconds: 1));
    print('Message from Earth: $messageFromEarth');
    if (messageFromEarth == 'Hey from Earth') {
      sendToEarthPort.send('Hey from Mars');
    } else if (messageFromEarth == 'Can you help?') {
      sendToEarthPort.send('sure');
    } else if (messageFromEarth == 'doSomething') {
      final result = await work.doSomething();
      sendToEarthPort.send({
        'method': 'doSomething',
        'result': result,
      });
    } else if (messageFromEarth == 'doSomethingElse') {
      final result = await work.doSomethingElse();
      sendToEarthPort.send({
        'method': 'doSomethingElse',
        'result': result,
      });

      sendToEarthPort.send('done');
    }
  });
}

class Earth {
  final _receiveOnEarthPort = ReceivePort();
  SendPort? _sendToMarsPort;
  Isolate? _marsIsolate;

  Future<void> contactMars() async {
    if (_marsIsolate != null) return;

    _marsIsolate = await Isolate.spawn<SendPort>(
      _entryPoint,
      _receiveOnEarthPort.sendPort,
    );

    _receiveOnEarthPort.listen((Object? messageFromMars) async {
      await Future<void>.delayed(Duration(seconds: 1));
      print('Message from Mars: $messageFromMars');
      // 1
      if (messageFromMars is SendPort) {
        _sendToMarsPort = messageFromMars;
        _sendToMarsPort?.send('Hey from Earth');
      }
      // 2
      else if (messageFromMars == 'Hey from Mars') {
        _sendToMarsPort?.send('Can you help?');
      } else if (messageFromMars == 'sure') {
        _sendToMarsPort?.send('doSomething');
        _sendToMarsPort?.send('doSomethingElse');
      }
      // 3
      else if (messageFromMars is Map) {
        final method = messageFromMars['method'] as String;
        final result = messageFromMars['result'] as int;
        print('The result of $method is $result');
      }
      // 4
      else if (messageFromMars == 'done') {
        print('shutting down');
        dispose();
      }
    });
  }

  void dispose() {
    _receiveOnEarthPort.close();
    _marsIsolate?.kill();
    _marsIsolate = null;
  }
}
