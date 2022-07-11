// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  synchronousCode();
  addingTaskToEventQueue();
  addingTaskToMicrotaskQueue();
  runningSynchronousCodeAfterEventQueueTask();
  delayingTasks();
}

void synchronousCode() {
  print('first');
  print('second');
  print('third');
}

void addingTaskToEventQueue() {
  print('first');
  Future(
    () => print('second'),
  );
  print('third');
}

void addingTaskToMicrotaskQueue() {
  print('first');
  Future(
    () => print('second'),
  );
  Future.microtask(
    () => print('third'),
  );
  print('fourth');
}

void runningSynchronousCodeAfterEventQueueTask() {
  print('first');
  Future(
    () => print('second'),
  ).then(
    (value) => print('third'),
  );
  Future(
    () => print('fourth'),
  );
  print('fifth');
}

void delayingTasks() {
  print('first');
  Future.delayed(
    Duration(seconds: 2),
    () => print('second'),
  );
  print('third');
}
