import 'dart:async';

Stream<void> readStream(Stream stream) async* {
  try {
    await for (final value in stream) {
      yield value;
    }
  } finally {
    print('Finally!');
  }
}

void main() async {
  final s = new StreamController<int>();
  s.onListen = () {
    s.add(1);
    s.add(2);
    s.addError(new Error());
    s.add(3);
  };

  readStream(s.stream).listen(print, onError: (e) => print('Error: $e'));
}
