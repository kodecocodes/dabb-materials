// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  /// Basic String Manipulation
  changingCase();
  trimming();
  padding();
  splittingAndJoining();
  findAndReplace();

  /// Building Strings
  stringBuffer();

  /// String Validation
  stringValidation();
  matchingLiteralCharacters();
  matchingAnySingleCharacter();
  matchingMultipleCharacters();
  matchingSetsOfCharacters();
  escapingSpecialCharacters();
  matchingBeginningEnd();
  validatePassword();

  /// Extracting Text
  extractingText();
  substringMultipleMatches();
  regexGroups();
}

void changingCase() {
  const userInput = 'sPoNgEbOb@eXaMpLe.cOm';
  final lowercase = userInput.toLowerCase();
  print(lowercase);
}

void trimming() {
  const userInput = ' 221B Baker St.   ';
  final trimmed = userInput.trim();
  print(trimmed);
}

void padding() {
  withoutPadding();
  withPadding();
}

void withoutPadding() {
  // final time = Duration(hours: 1, minutes: 32, seconds: 57);
  final time = Duration(hours: 1, minutes: 2, seconds: 3);
  final hours = time.inHours;
  final minutes = time.inMinutes % 60;
  final seconds = time.inSeconds % 60;
  final timeString = '$hours:$minutes:$seconds';
  print(timeString);
}

void withPadding() {
  final time = Duration(hours: 1, minutes: 2, seconds: 3);
  final hours = time.inHours;
  final minutes = '${time.inMinutes % 60}'.padLeft(2, '0');
  final seconds = '${time.inSeconds % 60}'.padLeft(2, '0');
  final timeString = '$hours:$minutes:$seconds';
  print(timeString);
}

void splittingAndJoining() {
  const csvFileLine = 'Martin,Emma,12,Paris,France';
  final fields = csvFileLine.split(',');
  print(fields);

  final joined = fields.join('-');
  print(joined);
}

void findAndReplace() {
  const phrase = 'live and learn';
  final withUnderscores = phrase.replaceAll(' ', '_');
  print(withUnderscores);
}

void stringBuffer() {
  // var message = 'Hello' + ' my name is ';
  // const name = 'Ray';
  // message += name;
  // 'Hello my name is Ray'

  final message = StringBuffer();
  message.write('Hello');
  message.write(' my name is ');
  message.write('Ray');
  message.toString();
  // 'Hello my name is Ray'

  for (int i = 2; i <= 1024; i *= 2) {
    print(i);
  }

  final buffer = StringBuffer();
  for (int i = 2; i <= 1024; i *= 2) {
    buffer.write(i);
    buffer.write(' ');
  }
  print(buffer);
}

void stringValidation() {
  print('String Validation:');

  const text = 'I love Dart';
  print(text.startsWith('I'));
  print(text.endsWith('Dart'));
  print(text.contains('love'));
  print(text.contains('Flutter'));
}

void matchingLiteralCharacters() {
  print('Matching Literal Characters:');

  final regex = RegExp('cat');
  print(regex.hasMatch('concatenation'));
  print(regex.hasMatch('dog'));
  print(regex.hasMatch('cats'));
  print('concatenation'.contains(regex));
  print('dog'.contains(regex));
  print('cats'.contains(regex));
}

void matchingAnySingleCharacter() {
  print('Matching Any Single Character');

  final matchSingle = RegExp('c.t');
  print(matchSingle.hasMatch('cat'));
  print(matchSingle.hasMatch('cot'));
  print(matchSingle.hasMatch('cut'));
  print(matchSingle.hasMatch('ct'));

  final optionalSingle = RegExp('c.?t');
  print(optionalSingle.hasMatch('cat'));
  print(optionalSingle.hasMatch('cot'));
  print(optionalSingle.hasMatch('cut'));
  print(optionalSingle.hasMatch('ct'));
}

void matchingMultipleCharacters() {
  print('Matching Multiple Characters');

  final oneOrMore = RegExp('wo+w');
  print(oneOrMore.hasMatch('ww'));
  print(oneOrMore.hasMatch('wow'));
  print(oneOrMore.hasMatch('wooow'));
  print(oneOrMore.hasMatch('wooooooow'));

  final zeroOrMore = RegExp('wo*w');
  print(zeroOrMore.hasMatch('ww'));
  print(zeroOrMore.hasMatch('wow'));
  print(zeroOrMore.hasMatch('wooow'));
  print(zeroOrMore.hasMatch('wooooooow'));

  final anyOneOrMore = RegExp('w.+w');
  print(anyOneOrMore.hasMatch('ww'));
  print(anyOneOrMore.hasMatch('wow'));
  print(anyOneOrMore.hasMatch('w123w'));
  print(anyOneOrMore.hasMatch('wABCDEFGw'));
}

void matchingSetsOfCharacters() {
  print('Matching Sets Of Characters:');

  final set = RegExp('b[oa]t');
  print(set.hasMatch('bat'));
  print(set.hasMatch('bot'));
  print(set.hasMatch('but'));
  print(set.hasMatch('boat'));
  print(set.hasMatch('bt'));

  final letters = RegExp('[a-zA-Z]');
  print(letters.hasMatch('a'));
  print(letters.hasMatch('H'));
  print(letters.hasMatch('3z'));
  print(letters.hasMatch('2'));

  final excluded = RegExp('b[^ao]t');
  print(excluded.hasMatch('bat')); // false
  print(excluded.hasMatch('bot')); // false
  print(excluded.hasMatch('but')); // true
  print(excluded.hasMatch('boat')); // false
  print(excluded.hasMatch('bt')); // false
}

void escapingSpecialCharacters() {
  print('Escaping Special Characters:');

  final escaped = RegExp(r'c\.t');
  print(escaped.hasMatch('c.t'));
  print(escaped.hasMatch('cat'));
}

void matchingBeginningEnd() {
  print('Matching Beginning and End:');

  final numbers = RegExp(r'[0-9]');
  print(numbers.hasMatch('5552021'));
  print(numbers.hasMatch('abcefg2'));

  final onlyNumbers = RegExp(r'^[0-9]+$');
  print(onlyNumbers.hasMatch('5552021'));
  print(onlyNumbers.hasMatch('abcefg2'));
}

void validatePassword() {
  const password = 'Password1234';

  final lowercase = RegExp(r'[a-z]');
  final uppercase = RegExp(r'[A-Z]');
  final number = RegExp(r'[0-9]');

  if (!password.contains(lowercase)) {
    print('Your password must have a lowercase letter!');
  } else if (!password.contains(uppercase)) {
    print('Your password must have an uppercase letter!');
  } else if (!password.contains(number)) {
    print('Your password must have a number!');
  } else {
    print('Your password is OK.');
  }

  if (password.length < 12) {
    print('Your password must be at least 12 characters long!');
  }

  final goodLength = RegExp(r'^.{12,}$');
  if (!password.contains(goodLength)) {
    print('Your password must be at least 12 characters long!');
  }
}

void extractingText() {
  const htmlText = '''
<!DOCTYPE html>
<html>
<body>
<h1>Dart Tutorial</h1>
<p>Dart is my favorite language.</p>
</body>
</html> 
''';

  var heading = htmlText.substring(34, 47);
  print(heading);

  final start = htmlText.indexOf('<h1>') + '<h1>'.length;
  final end = htmlText.indexOf('</h1>');
  heading = htmlText.substring(start, end);
  print(heading);
}

void substringMultipleMatches() {
  const text = '''
<h1>Dart Tutorial</h1>
<h1>Flutter Tutorial</h1>
<h1>Other Tutorials</h1>
''';

  var position = 0;
  while (true) {
    var start = text.indexOf('<h1>', position) + '<h1>'.length;
    var end = text.indexOf('</h1>', position);
    if (start == -1 || end == -1) {
      break;
    }
    final heading = text.substring(start, end);
    print(heading);
    position = end + '</h1>'.length;
  }
}

void regexGroups() {
  const text = '''
<h1>Dart Tutorial</h1>
<h1>Flutter Tutorial</h1>
<h1>Other Tutorials</h1>
''';

  final headings = RegExp(r'<h1>(.+)</h1>');
  final matches = headings.allMatches(text);

  for (final match in matches) {
    print(match.group(1));
  }
}
