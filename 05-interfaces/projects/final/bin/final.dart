// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  // final repository = DataRepository();
  // final DataRepository repository = FakeWebServer();
  // final temperature = repository.fetchTemperature('Berlin');

  final repository = DataRepository();
  final temperature = repository.fetchTemperature('Manila');
  print(temperature);

  final someClass = SomeClass();
  print(someClass.myField);
  someClass.myMethod();
}

abstract class DataRepository {
  factory DataRepository() => FakeWebServer();
  double? fetchTemperature(String city);
}

class FakeWebServer implements DataRepository {
  @override
  double? fetchTemperature(String city) {
    return 42.0;
  }
}

class AnotherClass {
  int myField = 42;
  void myMethod() => print(myField);
}

// class SomeClass extends AnotherClass {}
class SomeClass implements AnotherClass {
  @override
  int myField = 0;

  @override
  void myMethod() => print('Hello');
}
