// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  extendingClassesExercise1();
  extendingClassesExercise2();
  extendingClassesExercise3();
  interfacesExercises();
  mixinsExercise();

  challenge1();
  challenge2();
  challenge3();
}

/// Extending classes: Exercise 1
///
/// Create a class named `Fruit` with a `String` field named `color` and a
/// method named `describeColor` which uses `color` to print a message.
void extendingClassesExercise1() {
  final fruit = Fruit('yellow');
  fruit.describeColor();
}

class Fruit {
  Fruit(this.color);
  final color;
  void describeColor() {
    print("This fruit's color is $color.");
  }
}

/// Extending classes: Exercise 2
///
/// Create a subclass of `Fruit` named `Melon` and then create two `Melon`
/// subclasses named `Watermelon` and `Cantaloupe`.
void extendingClassesExercise2() {
  final melon = Melon('blue');
  final watermelon = Watermelon('red and green');
  final cantaloupe = Cantaloupe('orange');
  melon.describeColor();
  watermelon.describeColor();
  cantaloupe.describeColor();
}

class Melon extends Fruit {
  Melon(super.color);
}

// class Watermelon extends Melon {
//   Watermelon(super.color);
// }
class Cantaloupe extends Melon {
  Cantaloupe(super.color);
}

/// Extending classes: Mini-exercise 3
///
/// Override `describeColor` in the `Watermelon` class to vary the output.
void extendingClassesExercise3() {
  final fruit = Fruit('yellow');
  final watermelon = Watermelon('red and green');
  fruit.describeColor();
  watermelon.describeColor();
}

class Watermelon extends Melon {
  Watermelon(String color) : super(color);
  @override
  void describeColor() {
    print('The color of this watermelon is $color.');
  }
}

/// Interfaces Exercises
///
/// 1. Create an interface called `Bottle` and add a method to it
///    called `open`.
/// 2. Create a concrete class called `SodaBottle` that implements
///    `Bottle` and prints "Fizz fizz" when `open` is called.
/// 3. Add a factory constructor to `Bottle` that returns a `SodaBottle`
///    instance.
/// 4. Instantiate `SodaBottle` by using the `Bottle` factory constructor
///    and call `open` on the object.
void interfacesExercises() {
  final bottle = Bottle();
  bottle.open();
}

abstract class Bottle {
  factory Bottle() => SodaBottle();
  void open();
}

class SodaBottle implements Bottle {
  @override
  void open() {
    print('Fizz fizz');
  }
}

/// Mixins Exercises
///
/// 1. Create a class called `Calculator` with a method called `sum`
///    that prints the sum of the two arguments you give it.
/// 2. Extract the logic in `sum` to a mixin called `Adder`.
/// 3. Use the mixin in `Calculator`.
void mixinsExercise() {
  final calculator = Calculator();
  calculator.sum(4, 6);
}

// class Calculator {
//   void sum(num a, num b) {
//     print('The sum is ${a + b}.');
//   }
// }

class Calculator with Adder {}

mixin Adder {
  void sum(num a, num b) {
    print('The sum is ${a + b}.');
  }
}

/// Challenge 1: Heavy monotremes
///
/// Dart has a class named `Comparable` which is used by the the `sort` method
/// of `List` to sort its elements. Add a `weight` field to the `Platypus`
/// class you made in this lesson. Then make `Platypus` implement `Comparable`
/// so that when you have a list of `Platypus` objects, calling sort on the
/// list will sort them by weight.
void challenge1() {
  final willi = Platypus(weight: 1.0);
  final billi = Platypus(weight: 2.4);
  final nilli = Platypus(weight: 2.1);
  final jilli = Platypus(weight: 0.4);
  final silli = Platypus(weight: 1.7);

  final platypi = [willi, billi, nilli, jilli, silli];

  platypi.forEach((platypus) => print(platypus.weight));
  print('---');

  platypi.sort();
  platypi.forEach((platypus) => print(platypus.weight));
}

class Platypus extends Animal with EggLayer implements Comparable {
  Platypus({this.weight});
  final weight;

  @override
  void eat() {
    print('Munch munch');
  }

  @override
  void move() {
    print('Glide glide');
  }

  @override
  int compareTo(other) {
    if (weight > other.weight) {
      return 1;
    } else if (weight < other.weight) {
      return -1;
    }
    return 0;
  }
}

mixin EggLayer {
  void layEggs() {
    print('Plop plop');
  }
}

abstract class Animal {
  bool isAlive = true;
  void eat();
  void move();

  @override
  String toString() {
    return "I'm a $runtimeType";
  }
}

/// Challenge 2: Fake notes
///
/// Design an interface to sit between the business logic of your
/// note-taking app and a SQL database. After that, implement a fake
/// database class that will return mock data.
void challenge2() {
  final database = DataStorage();
  final note = database.findNote(42);
  final allNotes = database.allNotes();
  database.saveNote('Water the flowers.');
  print(note);
  print(allNotes);
}

abstract class DataStorage {
  factory DataStorage() => FakeDatabase();
  String findNote(int id);
  List<String> allNotes();
  void saveNote(String note);
}

class FakeDatabase implements DataStorage {
  @override
  String findNote(int id) {
    return 'This is a note.';
  }

  @override
  List<String> allNotes() {
    return [
      'This is a note.',
      'This is another note.',
      'Buy milk.',
      'Platypuses are nice.',
    ];
  }

  @override
  void saveNote(String note) {
    // Saving note to cyberspace....
  }
}

/// Challenge 3: Time to code
///
/// Dart has a `Duration` class for expressing lengths of time. Make an
/// extension on `int` so that you can express a duration like so:
///
/// ```
/// final timeRemaining = 3.minutes;
/// ```
void challenge3() {
  final timeRemaining = 3.minutes;
  print(timeRemaining);
}

extension on int {
  Duration get minutes => Duration(minutes: this);
}
