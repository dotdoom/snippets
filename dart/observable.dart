import 'package:observable/observable.dart';

class MyNumbers extends ObservableList<int>
    with ChangeNotifier<ChangeRecord>, PropertyChangeNotifier {
  @override
  void observed() {
    print('I am observed!');
    super.observed();
  }

  @override
  void unobserved() {
    print('I am unobserved!');
    super.unobserved();
  }
}

void main() async {
  final data = MyNumbers();

  data.listChanges.listen((c) {
    print('\nlistChanges:');
    c.forEach(print);
  });
  data.changes.listen((c) {
    print('\nchanges:');
    c.forEach(print);
  });

  data.add(1);
  print('added 1');
  await Future(() {});

  data.removeAt(0);
  print('removed 1');
  await Future(() {});

  final n1 = ObservableList<int>(), n2 = ObservableList<int>();
  n1.listChanges.listen((c) {
    print('\nApplying changes:');
    c.forEach(print);
    ObservableList.applyChangeRecords(n2, n1, c);
  });

  n1.add(0);
  n1.add(1);
  n1.add(2);
  n1.add(3);
  n1.add(4);

  n1.removeAt(3);
  n1.removeAt(0);
  n1.removeAt(1);

  n1.add(33);

  await Future(() {});
  print('\nAfter all the changes, it is:');
  print(n2);
}
