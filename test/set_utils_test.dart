import 'package:vy_string_utils/src/set/set_utils.dart';
import 'package:test/test.dart';

void main() {
  group('unfilledSet', () {
    test('null set', () {
      Set? test1;
      expect(unfilledSet(test1), isTrue);
      test1 = {null};
      expect(unfilledSet(test1), isFalse);
    });
    test('empty set', () {
      Set? test1 = {};
      expect(unfilledSet(test1), isTrue);
      test1.add(null);
      expect(unfilledSet(test1), isFalse);
    });
  });
  group('filledSet', () {
    test('null set', () {
      Set? test1;
      expect(filledSet(test1), isFalse);
      test1 = {null};
      expect(filledSet(test1), isTrue);
    });
    test('empty set', () {
      Set? test1 = {};
      expect(filledSet(test1), isFalse);
      test1.add(null);
      expect(filledSet(test1), isTrue);
    });
  });
}
