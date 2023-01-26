// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  basicStringManipulationExercise1();
  basicStringManipulationExercise2();
  buildingStringsExercise();
  stringValidationExercise();
  challenge1();
  challenge2();
}

/// Basic String Manipulation: Exercise 1
///
/// Take a multiline string, such as the text below, and split it into a
/// list of single lines. Hint: Split at the newline character.
///
/// ```
/// France
/// USA
/// Germany
/// Benin
/// China
/// Mexico
/// Mongolia
/// ```
void basicStringManipulationExercise1() {
  const countriesString = '''
France
USA
Germany
Benin
China
Mexico
Mongolia''';

  final countriesList = countriesString.split('\n');
  print(countriesList);
}

/// Basic String Manipulation: Exercise 2
///
/// Find an emoji online to replace `:]` with in the following text:
///
/// ```
/// How's the Dart book going? :]
/// ```
void basicStringManipulationExercise2() {
  const original = "How's the Dart book going? :]";
  final replaced = original.replaceAll(':]', '😊');
  print(replaced);
}

/// Building Strings Exercise
///
/// Use a string buffer to build the following string:
///
/// ```text
///  *********
/// * ********
/// ** *******
/// *** ******
/// **** *****
/// ***** ****
/// ****** ***
/// ******* **
/// ******** *
/// *********
/// ```
///
/// Hint: Use a loop inside of a loop.
void buildingStringsExercise() {
  final buffer = StringBuffer();
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      if (j == i) {
        buffer.write(' ');
      } else {
        buffer.write('*');
      }
    }
    buffer.write('\n');
  }
  print(buffer);
}

/// String Validation Exercise
///
/// Validate that a credit card number contains only numbers and is
/// exactly 16 digits long.
void stringValidationExercise() {
  final regex = RegExp(r'^[0-9]{16}$');
  print(regex.hasMatch('1111222233334444')); // true
  print(regex.hasMatch('123')); // false
  print(regex.hasMatch('aaaabbbbccccdddd')); // false
  print(regex.hasMatch('12341234123412345')); // false
}

/// Challenge 1: Email Validation
///
/// Write a regular expression to validate an email address.
void challenge1() {
  print('Challenge 1');

  // ^: start
  // \w+: alphanumeric characters
  // @: literal @
  // \.: literal .
  // $: end
  final regex = RegExp(r'^\w+@\w+\.\w+$');

  print(regex.hasMatch('me@example.com')); // true
  print(regex.hasMatch('my_email@example.com')); // true
  print(regex.hasMatch('my email@example.com')); // false
  print(regex.hasMatch('meexample.com')); // false
  print(regex.hasMatch('me@examplecom')); // false
}

/// Challenge 2: Karaoke Words
///
/// An LRC file contains the timestamps for the lyrics of a song. How would
/// you extract the time and lyrics for the following line of text:
///
/// ```
/// [00:12.34]Row, row, row your boat
/// ```
///
/// Extract the relevant parts of the string, and print them out in the
/// following format:
///
/// ```text
/// minutes: 00
/// seconds: 12
/// hundredths: 34
/// lyrics: Row, row, row your boat
/// ```
///
/// Solve the problem twice, once with `substring` and once with regex groups.
void challenge2() {
  print('Challenge 2');

  usingSubstring();
  usingRegexGroups();
}

void usingSubstring() {
  const line = '[00:12.34]Row, row, row your boat';
  final minutes = line.substring(1, 3);
  final seconds = line.substring(4, 6);
  final hundredths = line.substring(7, 9);
  final lyrics = line.substring(10);

  print('minutes: $minutes');
  print('seconds: $seconds');
  print('hundredths: $hundredths');
  print('lyrics: $lyrics');
}

void usingRegexGroups() {
  const line = '[00:12.34]Row, row, row your boat';

  // ^     start
  // \[    literal [
  // (\d+) group of digits
  // :     literal :
  // \.    literal .
  // \]    literal ]
  // (.+)  group of characters (lyrics)
  // $     end
  final regex = RegExp(r'^\[(\d+):(\d+)\.(\d+)\](.+)$');

  final match = regex.firstMatch(line);

  final minutes = match?.group(1);
  final seconds = match?.group(2);
  final hundredths = match?.group(3);
  final lyrics = match?.group(4);

  print('minutes: $minutes');
  print('seconds: $seconds');
  print('hundredths: $hundredths');
  print('lyrics: $lyrics');
}
