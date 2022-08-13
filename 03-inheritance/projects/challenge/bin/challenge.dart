// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  challenge1();
  challenge2();
}

/// Challenge 1: Fruity Colors
///
/// 1. Create a class named `Fruit` with a `String` field named `color` and
///    a method named `describeColor`, which uses `color` to print a message.
/// 2. Create a subclass of `Fruit` named `Melon` and then create two `Melon`
///    subclasses named `Watermelon` and `Cantaloupe`.
/// 3. Override `describeColor` in the `Watermelon` class to vary the output.
void challenge1() {
  final fruit = Fruit('yellow');
  final melon = Melon('blue');
  final watermelon = Watermelon('red and green');
  final cantaloupe = Cantaloupe('orange');

  fruit.describeColor();
  melon.describeColor();
  watermelon.describeColor();
  cantaloupe.describeColor();
}

class Fruit {
  Fruit(this.color);
  final String color;

  void describeColor() {
    print("This fruit's color is $color.");
  }
}

class Melon extends Fruit {
  Melon(super.color);
}

class Cantaloupe extends Melon {
  Cantaloupe(super.color);
}

class Watermelon extends Melon {
  Watermelon(String color) : super(color);

  @override
  void describeColor() {
    print('The color of this watermelon is $color.');
  }
}

/// Challenge 2: Composition Over Inheritance
///
/// 1. Create a `Person` class.
/// 2. Create a `Student` class that inherits from `Person`.
/// 3. Give the `Student` class a list of roles, including athlete, band member
///    and student union member. You can use an enum for the roles.
/// 4. Create some `Student` objects and give them various roles.
void challenge2() {
  final jane = Student('Jane', 'Snow');
  jane.roles.addAll([
    Role.athlete,
    Role.studentUnionMember,
    Role.bandMember,
  ]);
  print(jane.roles);

  final jessie = Student('Jessie', 'Jones');
  jessie.roles.add(Role.bandMember);
  print(jessie.roles);

  final marty = Student('Marty', 'McFly');
  marty.roles.add(Role.athlete);
  print(marty.roles);
}

class Person {
  Person(this.givenName, this.surname);

  String givenName;
  String surname;
  String get fullName => '$givenName $surname';

  @override
  String toString() => fullName;
}

class Student extends Person {
  Student(super.givenName, super.surname);
  final roles = <Role>[];
}

enum Role {
  athlete,
  bandMember,
  studentUnionMember,
}
