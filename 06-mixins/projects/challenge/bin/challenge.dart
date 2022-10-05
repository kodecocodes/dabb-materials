// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  challenge1();
  challenge2();
}

/// Challenge 1: Calculator
///
/// 1. Create a class called `Calculator` with a method called `sum`
///    that prints the sum of the two arguments you give it.
/// 2. Extract the logic in `sum` to a mixin called `Adder`.
/// 3. Use the mixin in `Calculator`.
void challenge1() {
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

/// Challenge 2: Heavy Monotremes
///
/// Dart has a class named `Comparable`, which is used by the `sort` method
/// of `List` to sort its elements.
///
/// 1. Add a `weight` field to the `Platypus` class you made earlier.
/// 2. Then make `Platypus` implement `Comparable` so that when you have a
///    list of `Platypus` objects, calling `sort` on the list will sort them
///    by weight.
void challenge2() {
  final willi = Platypus(weight: 1.0);
  final billi = Platypus(weight: 2.4);
  final nilli = Platypus(weight: 2.1);
  final jilli = Platypus(weight: 0.4);
  final silli = Platypus(weight: 1.7);

  final platypi = [willi, billi, nilli, jilli, silli];

  for (final platypus in platypi) {
    print(platypus.weight);
  }
  print('---');

  platypi.sort();
  for (final platypus in platypi) {
    print(platypus.weight);
  }
}

class Platypus extends Animal with EggLayer implements Comparable<Platypus> {
  Platypus({required this.weight});
  final double weight;

  @override
  void eat() {
    print('Munch munch');
  }

  @override
  void move() {
    print('Glide glide');
  }

  @override
  int compareTo(Platypus other) {
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
