import 'package:vy_string_utils/vy_string_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Cut', () {
    setUp(() {});

    test('Cut ok', () {
      //expect('please cut here this string'.cut(15), 'please cut here');
      expect(cut('please cut here this string', 15), 'please cut here');
      //expect('please cut'.cut(15), 'please cut');
      expect(cut('please cut', 15), 'please cut');
      expect(cut(null, 15), null);
    });

    test('Cut error', () {
/*      expect(() => null.cut(15), throwsNoSuchMethodError);
      expect(() => 'please cut'.cut(-1), throwsRangeError);*/
    });
  });

  group('Cut And Align', () {
    setUp(() {});

    /*   test('Cut And Align ok', () {
      expect('please cut here this string'.cutAndAlign(15), 'please cut here');*/
    /*     expect(
          'please cut here this string'
              .cutAndAlign(15, leftAlign: false, paddingChar: '*'),
          'please cut here');*/
    /*     expect('please cut'.cutAndAlign(15), 'please cut     ');
      expect('please cut'.cutAndAlign(15, leftAlign: false), '     please cut');
      expect('please cut'.cutAndAlign(15, paddingChar: '*'), 'please cut*****');
      expect('please cut'.cutAndAlign(15, leftAlign: false, paddingChar: '*'),
          '*****please cut');*/
  });

  test('Cut and Align error', () {
    //expect(() => null.cutAndAlign(15), throwsNoSuchMethodError);
    /*     expect(
          () =>
              'please cut'.cutAndAlign(-1, leftAlign: false, paddingChar: '*'),
          throwsRangeError);
    });*/
  });
  group('A group of tests', () {
    setUp(() {});

    test('Capitalize Test', () {
      expect(capitalize('main'), 'Main');
      expect(capitalize(null), isEmpty);
      expect(capitalize(''), isEmpty);
      expect(capitalize('m'), 'M');
      expect(capitalize('M'), 'M');
      expect(capitalize('i'), 'I');
      expect(capitalize('THETA'), 'Theta');
      expect(capitalize('jOhN'), 'John');
    });

    test('Empty or null', () {
      expect(unfilled(null), isTrue);
      expect(unfilled(''), isTrue);
      expect(unfilled('g'), isFalse);
      expect(unfilled('verify'), isFalse);
    });

    test('Only digits', () {
      expect(onlyContainsDigits('Value'), isFalse);
      expect(onlyContainsDigits(null), isFalse);
      expect(onlyContainsDigits(''), isFalse);
      expect(onlyContainsDigits('A234'), isFalse);
      expect(onlyContainsDigits('2712b'), isFalse);
      expect(onlyContainsDigits('12T24'), isFalse);
      expect(onlyContainsDigits('27-12'), isFalse);
      expect(onlyContainsDigits('1953'), isTrue);
    });
    test('Only alpha', () {
      expect(onlyContainsAlpha('Value'), isTrue);
      expect(onlyContainsAlpha(null), isFalse);
      expect(onlyContainsAlpha(''), isFalse);
      expect(onlyContainsAlpha('A234'), isFalse);
      expect(onlyContainsAlpha('2712b'), isFalse);
      expect(onlyContainsAlpha('12T24'), isFalse);
      expect(onlyContainsAlpha('27-12'), isFalse);
      expect(onlyContainsAlpha('1953'), isFalse);
      expect(onlyContainsAlpha('en_US'), isFalse);
    });
    test('Dart Identifier', () {
      String source = '''
      enum _LanguageType{ dart, cPlusPlus, c, java, python}
      ''';

      expect(isDartIdentifier(source, 12), isTrue);
      expect(isDartIdentifier(source, 11), isTrue);
      expect(isDartIdentifier(source, 10), isFalse);

      expect(getDartIdentifier(source, 10), '');
      expect(getDartIdentifier(source, 11), '_LanguageType');
      expect(getDartIdentifier(source, 12), 'LanguageType');
    });
    test('Dart Annotation Identifier', () {
      String source = '''
      enum @Annotate('Test note')
      ''';

      expect(isDartAnnotation(source, 12), isFalse);
      expect(isDartAnnotation(source, 11), isTrue);
      expect(isDartAnnotation(source, 10), isFalse);

      expect(getDartAnnotationIdentifier(source, 10), '');
      expect(getDartAnnotationIdentifier(source, 11), 'Annotate');
      expect(getDartAnnotationIdentifier(source, 12), '');
    });

    test('SplitInLines', () {
      String test = 'Lorem ipsum dolor sit amet, consectetur adipisci elit, '
          'sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrum exercitationem ullamco '
          'laboriosam, nisi ut aliquid ex ea commodi consequatur. '
          'Duis aute irure reprehenderit in voluptate velit esse cillum '
          'dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat '
          'non proident, sunt in culpa qui officia deserunt mollit anim '
          'id est laborum.';
      List<String> parts = splitInLines(test, 50);
      expect(parts.length, 10);
      expect(parts.first, 'Lorem ipsum dolor sit amet, consectetur adipisci ');
      expect(parts[5], 'aute irure reprehenderit in voluptate velit esse ');
      expect(parts.last, 'laborum.');
      List<String> parts1 = splitInLines(test, 50, separator: ',');
      expect(parts1.length, 11);
      expect(parts1.first, 'Lorem ipsum dolor sit amet,');
      expect(parts1[2], ' sed do eiusmod tempor incidunt ut labore et dolor');
      expect(parts1[3], 'e magna aliqua. Ut enim ad minim veniam,');
      expect(parts1.last, ' est laborum.');
      List<String> parts2 = splitInLines(test, 50, firstLineDecrease: 12);
      expect(parts2.length, 10);
      expect(parts2.first, 'Lorem ipsum dolor sit amet, ');
      expect(parts2[5], 'consequatur. Duis aute irure reprehenderit in ');
      expect(parts2.last, 'mollit anim id est laborum.');
      expect(test, parts.join());
      expect(parts.join(), parts1.join());
      expect(parts.join(), parts2.join());
    });
    test('SplitInLines 1', () {
      String test1 = 'consequatur';
      List<String> parts1 = splitInLines(test1, 10);
      expect(parts1.length, 2);
      expect(parts1.first, 'consequatu');
      expect(parts1.last, 'r');
      List<String> parts2 = splitInLines(test1, 11);
      expect(parts2.length, 1);
      expect(parts2.first, 'consequatur');
      List<String> parts3 = splitInLines(test1, 12);
      expect(parts3.length, 1);
      expect(parts3.first, 'consequatur');
      String test = 'Lorem amet';
      List<String> parts = splitInLines(test, 10);
      expect(parts.length, 1);
      expect(parts.first, 'Lorem amet');
    });

    test('SplitInLines 2', () {
      String test1 = 'consequatur mollit est';
      List<String> parts1 = splitInLines(test1, 10);
      expect(parts1.length, 3);
      expect(parts1.first, 'consequatu');
      expect(parts1[1], 'r mollit ');
      expect(parts1.last, 'est');
      List<String> parts2 = splitInLines(test1, 11);
      expect(parts2.length, 2);
      expect(parts2.first, 'consequatur');
      expect(parts2.last, ' mollit est');
      List<String> parts3 = splitInLines(test1, 12);
      expect(parts3.length, 2);
      expect(parts3.first, 'consequatur ');
      expect(parts3.last, 'mollit est');
      expect(test1, parts1.join());
      expect(test1, parts2.join());
      expect(test1, parts3.join());
    });

    test('SplitInLines 3', () {
      String test1 = 'mollit est consequatur';
      List<String> parts1 = splitInLines(test1, 10);
      expect(parts1.length, 4);
      expect(parts1.first, 'mollit ');
      expect(parts1[1], 'est ');
      expect(parts1[2], 'consequatu');
      expect(parts1.last, 'r');
      List<String> parts2 = splitInLines(test1, 11);
      expect(parts2.length, 2);
      expect(parts2.first, 'mollit est ');
      expect(parts2.last, 'consequatur');
      List<String> parts3 = splitInLines(test1, 12);
      expect(parts3.length, 2);
      expect(parts3.first, 'mollit est ');
      expect(parts3.last, 'consequatur');
      expect(test1, parts1.join());
      expect(test1, parts2.join());
      expect(test1, parts3.join());
    });
  });
}
