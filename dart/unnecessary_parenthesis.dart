class ClassWithFunction {
  Function f;
}

class UnnecessaryParenthesis {
  final value;
  UnnecessaryParenthesis() : value = (ClassWithFunction()..f = () => 42);
  //                                 ^                                 ^
}
