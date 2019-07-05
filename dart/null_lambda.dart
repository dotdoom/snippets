void testLambda(int x()) {
  print(x());
}

void main() {
  testLambda(() => 42);
  testLambda(null);
}
