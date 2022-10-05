// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  challenge1();
}

/// Challenge 1: Time to Code
///
/// Dart has a `Duration` class for expressing lengths of time. Make an
/// extension on `int` so that you can express a duration like so:
///
/// ```
/// final timeRemaining = 3.minutes;
/// ```
void challenge1() {
  final timeRemaining = 3.minutes;
  print(timeRemaining);
}

extension on int {
  Duration get minutes => Duration(minutes: this);
}
