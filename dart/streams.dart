import 'dart:async';

void main() {
  print('Started!');

  StreamController<String> s = new StreamController<String>.broadcast();
  s.onListen = () {
    print('StreamController#onListen()');

    s.sink.add('event1');
    s.sink.add('event2');
    scheduleMicrotask(() => s.sink.add('event3 (from scheduleMicrotask)'));
  };

  s.onCancel = () {
    print('StreamController#onCancel()');

    s.sink.add('event that nobody sees');
    // If we do s.close() here, onListen() will never fire again.
  };

  print('Subscribing, will cancel in 2 seconds.');
  var sub = s.stream.listen((String evt) {
    var sub2 = s.stream.listen((String evt2) {
      print('Subscription within subscription received: ${evt2}');
    });
    // If we don't do sub2.cancel, StreamController#onCancell will never fire.
    // Also, the last, print-everything subscription will not get any items!
    new Timer(new Duration(seconds: 1), sub2.cancel);

    print('Subscription received: ${evt}');
  });

  new Timer(new Duration(seconds: 2), sub.cancel);

  new Timer(new Duration(seconds: 4), () {
    print('Subscribing again and simply printing everything.');
    s.stream.listen(print);
  });
}
