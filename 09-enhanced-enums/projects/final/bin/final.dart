// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  reviewingBasics();
  addingConstructorsAndProperties();
  operatorOverloading();
  addingMethods();
  implementingInterfaces();
  addingMixins();
  usingGenerics();
}

void reviewingBasics() {
  const int GREEN = 0;
  const int YELLOW = 1;
  const int RED = 2;

  void printMessage(int lightColor) {
    switch (lightColor) {
      case GREEN:
        print('Go!');
        break;
      case YELLOW:
        print('Slow down!');
        break;
      case RED:
        print('Stop!');
        break;
      default:
        print('Unrecognized option');
    }
  }

  printMessage(GREEN);

  final color = TrafficLight.green;
  switch (color) {
    case TrafficLight.green:
      print('Go!');
      break;
    case TrafficLight.yellow:
      print('Slow down!');
      break;
    case TrafficLight.red:
      print('Stop!');
      break;
  }
}

enum TrafficLight {
  green('Go!'),
  yellow('Slow down!'),
  red('Stop!');

  const TrafficLight(this.message);
  final String message;
}

void addingConstructorsAndProperties() {
  final color = TrafficLight.green;
  print(color.message);
}

void operatorOverloading() {
  print(3 + 2);
  print('a' + 'b');

  const pointA = Point(1, 4);
  const pointB = Point(3, 2);
  final pointC = pointA + pointB;
  print(pointC);

  var day = Day.monday;
  day = day + 2;
  print(day.name);
  day += 4;
  print(day.name);
  day++;
  print(day.name);
}

class Point {
  const Point(this.x, this.y);
  final double x;
  final double y;

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  @override
  String toString() => '($x, $y)';
}

enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  Day get next {
    return this + 1;
  }

  Day operator +(int days) {
    final numberOfItems = Day.values.length;
    final index = (this.index + days) % numberOfItems;
    return Day.values[index];
  }
}

void addingMethods() {
  final restDay = Day.saturday;
  print(restDay.next);
}

void implementingInterfaces() {
  final weather = Weather.cloudy;
  String serialized = weather.serialize();
  print(serialized);
  Weather deserialized = Weather.deserialize(serialized);
  print(deserialized);
}

abstract class Serializable {
  String serialize();
}

enum Weather implements Serializable {
  sunny,
  cloudy,
  rainy;

  @override
  String serialize() => name;

  static Weather deserialize(String value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => Weather.sunny,
    );
  }
}

void addingMixins() {
  final fruit = Fruit.banana;
  final vegi = Vegetable.broccoli;

  fruit.describe();
  vegi.describe();
}

enum Fruit with Describer {
  cherry,
  peach,
  banana,
}

enum Vegetable with Describer {
  carrot,
  broccoli,
  spinach,
}

mixin Describer on Enum {
  void describe() {
    print('This $runtimeType is a $name.');
  }
}

void usingGenerics() {
  String defaultFont = Default.font.value;
  double defaultSize = Default.size.value;
  int defaultWeight = Default.weight.value;
  print(defaultFont);
  print(defaultSize);
  print(defaultWeight);
}

enum Size {
  small(1),
  medium(5),
  large(10);

  const Size(this.value);
  final int value;
}

enum Default<T extends Object> {
  font<String>('roboto'),
  size<double>(17.0),
  weight<int>(400);

  const Default(this.value);
  final T value;
}
