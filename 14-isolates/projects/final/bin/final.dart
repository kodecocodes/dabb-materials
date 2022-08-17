// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

import 'dart:io';
import 'dart:isolate';

Future<void> main() async {
  final earth = Earth();
  await earth.contactMars();
}

class Earth {
  final _receivePortOnEarth = ReceivePort();
  SendPort? _sendToMarsPort;
  Isolate? _marsIsolate;

  Future<void> contactMars() async {
    if (_marsIsolate != null) return;
    _marsIsolate = await Isolate.spawn(
      _entryPoint,
      _receivePortOnEarth.sendPort,
    );

    _receivePortOnEarth.listen((Object? messageFromMars) async {
      await Future.delayed(Duration(seconds: 1));
      print('Message from Mars: $messageFromMars');

      if (messageFromMars is SendPort) {
        _sendToMarsPort = messageFromMars;
        _sendToMarsPort?.send('Hey from Earth');
      } else if (messageFromMars == 'Hey from Mars') {
        _sendToMarsPort?.send('Can you help?');
      } else if (messageFromMars == 'sure') {
        _sendToMarsPort?.send('doSomething');
        _sendToMarsPort?.send('doSomethingElse');
      } else if (messageFromMars is Map) {
        final method = messageFromMars['method'];
        final result = messageFromMars['result'];
        print('The result of $method is $result');
      } else if (messageFromMars == 'done') {
        print('Shutting down');
        dispose();
      }
    });
  }

  void dispose() {
    _receivePortOnEarth.close();
    _marsIsolate?.kill();
    _marsIsolate = null;
  }
}

Future<void> _entryPoint(SendPort sendToEarthPort) async {
  final receivePortOnMars = ReceivePort();
  sendToEarthPort.send(receivePortOnMars.sendPort);
  final work = Work();

  receivePortOnMars.listen((Object? messageFromEarth) async {
    await Future.delayed(Duration(seconds: 1));
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
