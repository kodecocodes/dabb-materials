// Copyright (c) 2022 Razeware LLC
// For full license & permission details, see LICENSE.

void main() {
  usingGenerics();
  creatingGenericClasses();
  creatingGenericFunctions();
  genericsOfSpecifiedSubtypes();
}

void usingGenerics() {
  List<Object> snacks = ['chips', 'nuts', 42];

  List<int> integerList = [3, 1, 4];
  List<double> doubleList = [3.14, 8.0, 0.001];
  List<bool> booleanList = [true, false, false];

  Set<int> integerSet = {3, 1, 4};
  Map<int, String> intToStringMap = {1: 'one', 2: 'two', 3: 'three'};
}

void creatingGenericClasses() {
  final intTree = createIntTree();
  final stringTree = createStringTree();
}

class IntNode {
  IntNode(this.value);
  int value;

  IntNode? leftChild;
  IntNode? rightChild;
}

Node<int> createIntTree() {
  final zero = Node(0);
  final one = Node(1);
  final five = Node(5);
  final seven = Node(7);
  final eight = Node(8);
  final nine = Node(9);

  seven.leftChild = one;
  one.leftChild = zero;
  one.rightChild = five;
  seven.rightChild = nine;
  nine.leftChild = eight;

  return seven;
}

class StringNode {
  StringNode(this.value);
  String value;

  StringNode? leftChild;
  StringNode? rightChild;
}

Node<String> createStringTree() {
  final zero = Node('zero');
  final one = Node('one');
  final five = Node('five');
  final seven = Node('seven');
  final eight = Node('eight');
  final nine = Node('nine');

  seven.leftChild = one;
  one.leftChild = zero;
  one.rightChild = five;
  seven.rightChild = nine;
  nine.leftChild = eight;

  return seven;
}

class BooleanNode {
  BooleanNode(this.value);
  bool value;

  BooleanNode? leftChild;
  BooleanNode? rightChild;
}

class DoubleNode {
  DoubleNode(this.value);
  double value;

  DoubleNode? leftChild;
  DoubleNode? rightChild;
}

class Node<T> {
  Node(this.value);
  T value;

  Node<T>? leftChild;
  Node<T>? rightChild;

  @override
  String toString() {
    final left = leftChild?.toString() ?? '';
    final parent = value.toString();
    final right = rightChild?.toString() ?? '';
    return '$left $parent $right';
  }
}

void creatingGenericFunctions() {
  // final tree = createTree([7, 1, 9, 0, 5, 8]);
  final tree = createTree(['seven', 'one', 'nine', 'zero', 'five', 'eight']);

  print(tree?.value);
  print(tree?.leftChild?.value);
  print(tree?.rightChild?.value);
  print(tree?.leftChild?.leftChild?.value);
  print(tree?.leftChild?.rightChild?.value);
  print(tree?.rightChild?.leftChild?.value);
  print(tree?.rightChild?.rightChild?.value);
}

Node<E>? createTree<E>(List<E> nodes, [int index = 0]) {
  if (index >= nodes.length) return null;

  final node = Node(nodes[index]);

  final leftChildIndex = 2 * index + 1;
  final rightChildIndex = 2 * index + 2;

  node.leftChild = createTree(nodes, leftChildIndex);
  node.rightChild = createTree(nodes, rightChildIndex);

  return node;
}

void genericsOfSpecifiedSubtypes() {
  var tree = BinarySearchTree<num>();
  tree.insert(7);
  tree.insert(1);
  tree.insert(9);
  tree.insert(0);
  tree.insert(5);
  tree.insert(8);
  print(tree);
}

class BinarySearchTree<E extends Comparable<E>> {
  Node<E>? root;

  void insert(E value) {
    root = _insertAt(root, value);
  }

  Node<E> _insertAt(Node<E>? node, E value) {
    if (node == null) {
      return Node(value);
    }

    if (value.compareTo(node.value) < 0) {
      node.leftChild = _insertAt(node.leftChild, value);
    } else {
      node.rightChild = _insertAt(node.rightChild, value);
    }

    return node;
  }

  @override
  String toString() => root.toString();
}
