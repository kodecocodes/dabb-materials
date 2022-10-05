// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  challenge1();
  challenge2();
}

/// Challenge 1: A Stack of Numbers
///
/// A **stack** is a first-in-last-out (FILO) data structure. When you add
/// new values, you put them on top of the stack, covering up the old values.
/// Likewise, when you remove values from the stack, you can only remove them
/// from the top of the stack.
///
/// Create a class named `IntStack` with the following methods:
///
/// - `push`: adds an integer to the top of the stack.
/// - `pop`: removes and returns the top integer from the stack.
/// - `peek`: tells the value of the top integer in the stack without removing it.
/// - `isEmpty`: tells whether the stack is empty or not.
/// - `toString`: returns a string representation of the stack.
///
/// Use a `List` as the internal data structure.
void challenge1() {
  final stack = IntStack();
  stack.push(9);
  stack.push(2);
  stack.push(5);
  stack.push(3);
  print(stack.pop());
  print(stack.peek());
  print(stack.isEmpty());
  print(stack);
}

class IntStack {
  final List<int> _list = [];

  void push(int value) => _list.add(value);

  int pop() => _list.removeLast();

  int peek() => _list.last;

  bool isEmpty() => _list.isEmpty;

  @override
  String toString() => _list.toString();
}

/// Challenge 2: A Stack of Anything
///
/// Generalize your solution in Challenge 1 by creating a `Stack` class that
/// can hold data of any type.
void challenge2() {
  final intStack = Stack<int>();
  intStack.push(9);
  intStack.push(2);
  intStack.push(5);
  intStack.push(3);
  print(intStack.pop());
  print(intStack.peek());
  print(intStack.isEmpty());
  print(intStack);

  final stringStack = Stack<String>();
  stringStack.push('nine');
  stringStack.push('two');
  stringStack.push('five');
  stringStack.push('three');
  print(stringStack.pop());
  print(stringStack.peek());
  print(stringStack.isEmpty());
  print(stringStack);
}

class Stack<E> {
  final List<E> _list = [];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E peek() => _list.last;

  bool isEmpty() => _list.isEmpty;

  @override
  String toString() => _list.toString();
}
