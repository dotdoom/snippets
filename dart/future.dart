import 'dart:async';

Future<void> b(value) async {
  await Future.delayed(Duration(seconds: 0));
  print('b(${value})');
}

Future<void> a(value) async {
  print('a(${value})');
  scheduleMicrotask(() => b(value));
  // await b(value);
  return value + 1;
}

void main() {
  scheduleMicrotask(() => print('microtask1'));
  a(1).then(a).then(a);
  print('done');
  scheduleMicrotask(() => print('microtask2'));
}
