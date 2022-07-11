// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  challenge1();
  challenge2();
}

/// Challenge 1: Fizzy Bottles
///
/// 1. Create an interface called `Bottle` and add a method to it
///    called `open`.
/// 2. Create a concrete class called `SodaBottle` that implements
///    `Bottle` and prints "Fizz fizz" when `open` is called.
/// 3. Add a factory constructor to `Bottle` that returns a `SodaBottle`
///    instance.
/// 4. Instantiate `SodaBottle` by using the `Bottle` factory constructor
///    and call `open` on the object.
void challenge1() {
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
