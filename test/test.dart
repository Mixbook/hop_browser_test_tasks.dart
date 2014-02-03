library test;

import 'package:unittest/unittest.dart';

void main() {
  test("add operator", () => expect(2 + 1, equals(4)));
  test("minus operator", () => expect(2 - 1, equals(1)));
}