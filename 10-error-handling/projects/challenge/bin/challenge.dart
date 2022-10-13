// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  challenge1();
  challenge2();
}

/// Challenge 1: Double the Fun
///
/// Here is a list of strings. Try to parse each of them with `double.parse`.
/// Handle any format exceptions that occur.
///
/// ```
/// final numbers = ['3', '1E+8', '1.25', 'four', '-0.01', 'NaN', 'Infinity'];
/// ```
void challenge1() {
  final numbers = ['3', '1E+8', '1.25', 'four', '-0.01', 'NaN', 'Infinity'];
  for (final number in numbers) {
    try {
      final parsed = double.parse(number);
      print('The number is $parsed');
    } on FormatException {
      print('$number can\'t be parsed.');
    }
  }
}

/// Challenge 2: Five Digits, No More, No Less
///
/// - Create a custom exception named `InvalidPostalCode`.
/// - Validate that a postal code is five digits
/// - If it isn't, throw the exception.
void challenge2() {
  // You could also solve this with an `int` type.
  const postalCode = '123456';

  try {
    validate(postalCode);
  } on InvalidPostalCode catch (e) {
    print(e.message);
  }
}

void validate(String postalCode) {
  try {
    int.parse(postalCode);
  } on FormatException {
    throw InvalidPostalCode('The postal code must be a valid number');
  }

  if (postalCode.length != 5) {
    throw InvalidPostalCode('The postal code must be five digits long.');
  }
}

class InvalidPostalCode implements Exception {
  InvalidPostalCode(this.message);
  final String message;
}
