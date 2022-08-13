// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  challenge1();
}

/// Challenge 1: Saving It Somewhere
///
/// 1. Create an abstract class named `Storage` with `print` statements in
///    the `save` and `retrieve` methods.
/// 2. Extend `Storage` with concrete classes named `LocalStorage` and
///    `CloudStorage`.
void challenge1() {
  final database = LocalStorage();
  database.save('42');
  print(database.retrieve());

  final cloud = CloudStorage();
  cloud.save('24');
  print(cloud.retrieve());
}

abstract class Storage {
  void save(String data) {
    print('Data storage not implemented');
  }

  String retrieve() {
    print('Data retrieval not implemented');
    return '';
  }
}

class LocalStorage extends Storage {
  String _data = '';

  @override
  void save(String data) {
    print('Saving "$data" in a local database...');
    _data = data;
  }

  @override
  String retrieve() {
    print('Retrieving data from the database...');
    return _data;
  }
}

class CloudStorage extends Storage {
  String _data = '';

  @override
  void save(String data) {
    print('Saving "$data" to the cloud...');
    _data = data;
  }

  @override
  String retrieve() {
    print('Retrieving data from the cloud...');
    return _data;
  }
}
