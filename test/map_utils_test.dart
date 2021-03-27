import 'package:vy_string_utils/src/map/map_utils.dart';
import 'package:test/test.dart';

void main() {
  group('unfilledMap', () {
    test('null map', () {
      Map? test1;
      expect(unfilledMap(test1), isTrue);
      test1 = {null: null};
      expect(unfilledMap(test1), isFalse);
    });
    test('empty map', () {
      Map? test1 = {};
      expect(unfilledMap(test1), isTrue);
      test1['1'] = 'a';
      expect(unfilledMap(test1), isFalse);
    });
  });
  group('filledMap', () {
    test('null map', () {
      Map? test1;
      expect(filledMap(test1), isFalse);
      test1 = {'a': 10};
      expect(filledMap(test1), isTrue);
    });
    test('empty map', () {
      Map? test1 = {};
      expect(filledMap(test1), isFalse);
      test1['a'] = 5;
      expect(filledMap(test1), isTrue);
    });
  });
}
