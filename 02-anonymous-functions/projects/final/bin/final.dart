// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  assigningFunctionsToVariables();
  passingFunctionsToFunctions();
  returningFunctionsFromFunctions();
  iteratingOverAList();
  iteratingOverAMap();
  mapping();
  filtering();
  reducing();
  folding();
  sorting();
  combiningHigherOrderMethods();
  voidCallback();
  valueSetterCallback();
  valueGetterCallback();
  tearOffs();
  typedefs();
  closures();
}

void assigningFunctionsToVariables() {
  int number = 4;
  String greeting = 'hello';
  bool isHungry = true;

  Function multiply = (int a, int b) {
    return a * b;
  };
}

void passingFunctionsToFunctions() {
  void namedFunction(Function anonymousFunction) {
    // function body
  }
}

void returningFunctionsFromFunctions() {
  Function namedFunction() {
    return () => print('hello');
  }
}

void iteratingOverAList() {
  const numbers = [1, 2, 3];

  numbers.forEach((int number) {
    print(3 * number);
  });

  numbers.forEach((number) {
    print(3 * number);
  });

  numbers.forEach((number) => print(3 * number));

  for (final number in numbers) {
    print(3 * number);
  }

  final triple = (int x) => print(3 * x);
  numbers.forEach(triple);
}

void iteratingOverAMap() {
  final flowerColor = {
    'roses': 'red',
    'violets': 'blue',
  };

  flowerColor.forEach((flower, color) {
    print('$flower are $color');
  });

  print('i \u2764 Dart');
  print('and so do you');
}

void mapping() {
  const numbers = [2, 4, 6, 8, 10, 12];

  final looped = <int>[];
  for (final x in numbers) {
    looped.add(x * x);
  }
  print(looped);

  final mapped = numbers.map((x) => x * x);
  print(mapped);
  print(mapped.toList());
}

void filtering() {
  final myList = [1, 2, 3, 4, 5, 6];
  final odds = myList.where((element) => element.isOdd);
  print(odds);
}

void reducing() {
  const evens = [2, 4, 6, 8, 10, 12];
  final total = evens.reduce((sum, element) => sum + element);
  print(total);

  // final emptyList = <int>[];
  // final result = emptyList.reduce((sum, x) => sum + x);
}

void folding() {
  const evens = [2, 4, 6, 8, 10, 12];
  final total = evens.fold(
    0,
    (sum, element) => sum + element,
  );
  print(total);

  final emptyList = <int>[];
  final result = emptyList.fold(
    0,
    (sum, element) => sum + element,
  );
  print(result);
}

void sorting() {
  final desserts = ['cookies', 'pie', 'donuts', 'brownies'];

  desserts.sort();
  print(desserts);

  desserts.sort((d1, d2) => d1.length.compareTo(d2.length));
  print(desserts);
}

void combiningHigherOrderMethods() {
  declarative();
  imperative();
}

void declarative() {
  const desserts = ['cake', 'pie', 'donuts', 'brownies'];
  final bigTallDesserts = desserts
      .where((dessert) => dessert.length > 5)
      .map((dessert) => dessert.toUpperCase())
      .toList();
  print(bigTallDesserts);
}

void imperative() {
  const desserts = ['cake', 'pie', 'donuts', 'brownies'];
  final bigTallDesserts = <String>[];
  for (final item in desserts) {
    if (item.length > 5) {
      final upperCase = item.toUpperCase();
      bigTallDesserts.add(upperCase);
    }
  }
  print(bigTallDesserts);
}

class Button {
  Button({
    required this.title,
    required this.onPressed,
  });

  final String title;
  // final Function onPressed;
  final void Function() onPressed;
}

void voidCallback() {
  final myButton = Button(
    title: 'Click me!',
    onPressed: () {
      print('Clicked');
    },
  );
  myButton.onPressed();
  myButton.onPressed.call();

  // final anotherButton = Button(
  //   title: 'Click me, too!',
  //   onPressed: (int apple) {
  //     print('Clicked');
  //     return 42;
  //   },
  // );
}

class MyWidget {
  MyWidget({
    required this.onTouch,
  });

  final void Function(double xPosition) onTouch;
}

void valueSetterCallback() {
  final myWidget = MyWidget(
    onTouch: (x) => print(x),
  );
  myWidget.onTouch(3.14);
}

class AnotherWidget {
  AnotherWidget({
    this.timeStamp,
  });

  final String Function()? timeStamp;
}

void valueGetterCallback() {
  final myWidget = AnotherWidget(
    timeStamp: () => DateTime.now().toIso8601String(),
  );

  final timeStamp = myWidget.timeStamp?.call();
  print(timeStamp);
}

class StateManager {
  int _counter = 0;

  void handleButtonClick() {
    _counter++;
  }
}

void tearOffs() {
  final manager = StateManager();

  final myButton = Button(
    title: 'Click me!',
    onPressed: manager.handleButtonClick,
  );
  myButton.onPressed();

  const cities = ['Istanbul', 'Ankara', 'Izmir', 'Bursa', 'Antalya'];
  cities.forEach((city) => print(city));

  cities.forEach(print);
}

typedef MapBuilder = Map<String, int> Function(List<int>);
typedef ZipCode = int;

class Gizmo {
  Gizmo({
    required this.builder,
  });

  final MapBuilder builder;
}

void typedefs() {
  final gizmo = Gizmo(builder: (list) => {'hi': list.first});

  ZipCode code = 87101;
  int number = 42;

  print(code is ZipCode);
  print(code is int);
  print(number is ZipCode);
  print(number is int);
}

void closures() {
  var counter = 0;
  final incrementCounter = () {
    counter += 1;
  };

  incrementCounter();
  incrementCounter();
  incrementCounter();
  incrementCounter();
  incrementCounter();
  print(counter);

  final counter1 = countingFunction();
  final counter2 = countingFunction();
  print(counter1());
  print(counter2());
  print(counter1());
  print(counter1());
  print(counter2());
}

Function countingFunction() {
  var counter = 0;
  final incrementCounter = () {
    counter += 1;
    return counter;
  };
  return incrementCounter;
}
