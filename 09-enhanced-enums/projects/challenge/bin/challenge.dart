// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  challenge1();
  challenge2();
}

/// Challenge 1: Better Days Ahead
///
/// In this chapter, you wrote a `Day` enum with the seven days of the week.
///
/// 1. Override the `-` operator so that you can subtract integers from
///    enum values.
/// 2. When you print the `name` of your `Day` enum, it prints the days of
///    the week in all lowercase. It's standard to use lower camel case for
///    enum values, but it would be nice to use uppercase for the display name.
///    For example, `Monday` instead of `monday`. Add a `displayName` property
///    to `Day` for that.
void challenge1() {
  challengeOnePart1();
  challengeOnePart2();
}

void challengeOnePart1() {
  var day = Day.monday;
  day = day + 2;
  print(day.name);
  day += 4;
  print(day.name);
  day++;
  print(day.name);

  day--;
  print(day.name);
  day -= 4;
  print(day.name);
  day = day - 2;
  print(day.name);
}

void challengeOnePart2() {
  for (final day in Day.values) {
    print(day.displayName);
  }
}

enum Day {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday');

  const Day(this.displayName);
  final String displayName;

  Day get next {
    return this + 1;
  }

  Day operator +(int days) => _combine(days, true);

  Day operator -(int days) => _combine(days, false);

  Day _combine(int days, bool isAdding) {
    final sign = (isAdding) ? 1 : -1;
    final numberOfItems = Day.values.length;
    final index = (this.index + sign * days) % numberOfItems;
    return Day.values[index];
  }
}

/// Challenge 2: Not Found, 404
///
/// Create an enum for HTTP response status codes. The enum should have
/// properties for the code and the meaning. For example, `404` and
/// `'Not Found'`. If you aren't familiar with the HTTP codes, look them up
/// online. You don't need to cover every possible code, just a few of the
/// common ones.
void challenge2() {
  for (final status in StatusCode.values) {
    print('Status: ${status.code}, ${status.meaning}');
  }
}

enum StatusCode {
  ok(200, 'OK'),
  badRequest(400, 'Bad Request'),
  unauthorized(401, 'Unauthorized'),
  forbidden(403, 'Forbidden'),
  notFound(404, 'Not Found'),
  methodNotAllowed(405, 'Method Not Allowed'),
  imaTeapot(418, "I'm a teapot"),
  internalServerError(500, 'Internal Server Error');

  const StatusCode(this.code, this.meaning);
  final int code;
  final String meaning;
}
