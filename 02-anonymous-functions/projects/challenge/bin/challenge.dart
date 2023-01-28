// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  higherOrderFunctionsExercise();
  callbackFunctionsExercise();

  challenge1();
  challenge2();
}

/// Exercise: Higher-Order Functions
///
/// Given the following exam scores:
///
/// ```dart
/// final scores = [89, 77, 46, 93, 82, 67, 32, 88];
/// ```
///
/// 1. Use `sort` to order the grades from highest to lowest.
/// 2. Use `where` to find all the B grades, that is, all the scores
///    between `80` and `90`.
void higherOrderFunctionsExercise() {
  final scores = [89, 77, 46, 93, 82, 67, 32, 88];
  scores.sort((a, b) => b.compareTo(a));
  print('Hightest to lowest: $scores');
  final highest = scores.first;
  final lowest = scores.last;
  print(highest);
  print(lowest);

  final bGrades = scores.where((score) => score >= 80 && score < 90);
  print(bGrades);
}

/// Exercise: Callback Functions
void callbackFunctionsExercise() {
  /// 5. In `main`, create an instance of `Surface` and pass in an anonymous
  ///    function that prints the x,y coordinates.
  final surface = Surface((x, y) => print('($x, $y)'));

  /// 6. Still in `main`, call `touch` where x is `202.3` and y is `134.0`.
  surface.touch(202.333, 134.0);
}

/// 3. Make a type alias named `TouchHandler` for the callback function.
typedef TouchHandler = void Function(double x, double y);

/// 1. Create a class named `Surface`.
class Surface {
  Surface(this.onTouch);

  /// 2. Give the class a property named `onTouch`, which is a
  ///    callback function that provides x,y coordinates but returns nothing.
  final TouchHandler onTouch;

  /// 4. In `Surface`, create a method named `touch`, which takes x,y
  ///    coordinates and then internally calls `onTouch`.
  void touch(double x, double y) => onTouch(x, y);
}

/// Challenge 1: Animalsss
///
/// Given the map below:
///
/// ```
/// final animals = {
///   'sheep': 99,
///   'goats': 32,
///   'snakes': 7,
///   'lions': 80,
///   'seals': 18,
/// };
/// ```
///
/// User higher-order functions to find the total number of animals whose
/// names begin with "s". That is, how many sheep, snakes and seals are there?
void challenge1() {
  final animals = {
    'sheep': 99,
    'goats': 32,
    'snakes': 7,
    'lions': 80,
    'seals': 18,
  };

  final totalBeginningWithS = animals.keys
      .where((key) => key.startsWith('s'))
      .fold(0, (int sum, key) => sum + (animals[key] ?? 0));
  print(totalBeginningWithS);
}

/// Challenge 2: Can you repeat that?
///
/// Write a function named `repeatTask` that looks like this:
///
/// ```
/// int repeatTask(int times, int input, Function task)
/// ```
///
/// It repeats a given `task` on `input` for `times` number of times.
///
/// Pass an anonymous function to `repeatTask` to square the input
/// of 2 four times. Confirm that you get the result 65536, since
/// 2 squared is 4,
/// 4 squared is 16,
/// 16 squared is 256, and
/// 256 squared is 65536.
void challenge2() {
  int repeatTask(int times, int input, Function task) {
    int result = task(input);
    for (var i = 1; i < times; i++) {
      result = task(result);
    }
    return result;
  }

  final result = repeatTask(4, 2, (num input) {
    return input * input;
  });

  print(result);
}
