// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  final john = Person('John', 'Snow');
  final jane = Student('Jane', 'Snow');
  print(john.fullName);
  print(jane.fullName);

  final historyGrade = Grade.B;
  jane.grades.add(historyGrade);
  print(jane.grades);

  final child = SomeChild();
  child.doSomeWork();

  final jessie = SchoolBandMember('Jessie', 'Jones');
  final marty = StudentAthlete('Marty', 'McFly');
  print(jessie);
  print(marty);

  final students = [jane, jessie, marty];

  print(jessie is Object);
  print(jessie is Person);
  print(jessie is Student);
  print(jessie is SchoolBandMember);
  print(jessie is! StudentAthlete);
}

enum Grade { A, B, C, D, F }

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
  var grades = <Grade>[];
  @override
  String get fullName => '$surname, $givenName';
}

class SomeParent {
  void doSomeWork() {
    print('parent working');
  }
}

class SomeChild extends SomeParent {
  @override
  void doSomeWork() {
    print('child doing some other work');
    super.doSomeWork();
  }
}

class SchoolBandMember extends Student {
  SchoolBandMember(super.givenName, super.surname);

  static const minimumPracticeTime = 2;
}

class StudentAthlete extends Student {
  StudentAthlete(super.givenName, super.surname);

  bool get isEligible => grades.every((grade) => grade != Grade.F);
}
