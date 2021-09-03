import 'package:vy_string_utils/src/list/list_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Convert list to type', () {
    setUp(() {});

    test('Simple convert', () {
      var fool = [0, 'foo', 10, null];
      var dest = convertListToType<String>(fool);
      expect(dest.isNotEmpty, isTrue);
      expect(dest.length, 1);
      expect(dest.first, 'foo');
      var destInt = convertListToType<int>(fool);
      expect(destInt.isNotEmpty, isTrue);
      expect(destInt.length, 2);
      expect(destInt.last, 10);
    });

    test('With discard list', () {
      var fool = [0, 'foo', 10, null];

      var discarded = <Object?>[];
      var dest = convertListToType<String>(fool, discardedList: discarded);
      expect(dest.isNotEmpty, isTrue);
      expect(dest.length, 1);
      expect(dest.first, 'foo');
      expect(discarded, isNotEmpty);
      expect(discarded.length, 3);
      expect(discarded.first, 0);
      expect(discarded.last, isNull);

      // discarde list is cleaned on entry
      var destInt = convertListToType<int>(fool, discardedList: discarded);
      expect(destInt.isNotEmpty, isTrue);
      expect(destInt.length, 2);
      expect(destInt.last, 10);
      expect(discarded, isNotEmpty);
      expect(discarded.length, 2);
      expect(discarded.first, 'foo');
      expect(discarded.last, isNull);
    });
    test('Complex convert', () {
      var fooList = /* <Map<String, Object?>> */ [
        {'first': 4},
        {'second': 'John'},
        {'third': null},
      ];
      print('ListType: ${fooList.runtimeType}');
      for (var element in fooList) {
        print('$element, ${element.runtimeType}');
      }
      var dest = convertListToType<Map<String, Object>>(fooList);
      expect(dest.isNotEmpty, isTrue);
      expect(dest.length, 2);
      expect(dest.first['first'], 4);
      expect(dest.last['second'], 'John');

      var destString = convertListToType<Map<String, String>>(fooList);
      expect(destString.isNotEmpty, isTrue);
      expect(destString.length, 1);
      expect(destString.first['second'], 'John');
    });

    test('test test', () {
      var fooList = <List<Object>>[
        ['key'],
      ];
     /*  print('ListType: ${fooList.runtimeType}');
      for (var element in fooList) {
        print('$element, ${element.runtimeType}');
      } */
      var list = <List<Object>>[['foo']];
      print('$list, ${list.runtimeType}');
       for (var element in list) {
        print('$element, ${element.runtimeType}');
      }
    });

    test('Complex With discard list', () {
      var fool = [
        {'first': 4},
        {'second': 'John'},
        {'third': null},
      ];
      var discarded = <Map<String, Object?>>[];

      var dest = convertListToType<Map<String, Object>>(fool,
          discardedList: discarded);
      expect(dest.isNotEmpty, isTrue);
      expect(dest.length, 2);
      expect(dest.first['first'], 4);
      expect(dest.last['second'], 'John');
      expect(discarded, isNotEmpty);
      expect(discarded.length, 1);
      expect(discarded.first.containsKey('third'), isTrue);

      var destString = convertListToType<Map<String, String>>(fool,
          discardedList: discarded);
      expect(destString.isNotEmpty, isTrue);
      expect(destString.length, 1);
      expect(destString.first['second'], 'John');
      expect(discarded, isNotEmpty);
      expect(discarded.length, 2);
      expect(discarded.first['first'], 4);
      expect(discarded.last.containsKey('third'), isTrue);
    });
  });

  group('unfilledList', () {
    test('null list', () {
      List? test1;
      expect(unfilledList(test1), isTrue);
      test1 = [null];
      expect(unfilledList(test1), isFalse);
    });
    test('empty list', () {
      List? test1 = [];
      expect(unfilledList(test1), isTrue);
      test1.add(null);
      expect(unfilledList(test1), isFalse);
    });
  });
  group('filledList', () {
    test('null list', () {
      List? test1;
      expect(filledList(test1), isFalse);
      test1 = [null];
      expect(filledList(test1), isTrue);
    });
    test('empty list', () {
      List? test1 = [];
      expect(filledList(test1), isFalse);
      test1.add(null);
      expect(filledList(test1), isTrue);
    });
  });
}
