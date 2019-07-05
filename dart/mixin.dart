class A {
  void write() => print('write');
  void read() => print('read');
}

class ReadOnlyMixin {
  void write() => throw 'cannot write';
}

class B extends A with ReadOnlyMixin {
  void rewrite() {
    super.read();
    // cannot do this: super(A).write();
    // super.write() will call ReadOnlyMixin.write() throwing an exception.
  }
}

abstract class PrintAndCallSuperMixin implements A {
  void write() {
    // Won't be called because ReadOnlyMixin is last in list of C mixins
    // and it doesn't call super.
    print('About to call super');
    super.write();
    print('Just called super');
  }
}

class C extends A with PrintAndCallSuperMixin, ReadOnlyMixin {
}

void main() {
  var b = new B();
  b.read();
  try {
    b.write();
  } catch(e) {
    print('$e, which is expected');
  }
  b.rewrite();

  var c = new C();
  c.write();
}
