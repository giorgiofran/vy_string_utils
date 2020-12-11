/// Copyright © 2020 Giorgio Franceschetti. All rights reserved.

import 'package:vy_string_utils/vy_string_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Cut', () {
    setUp(() {});

    test('Cut ok', () {
      expect('please cut here this string'.cut(15), 'please cut here');
      expect(cut('please cut here this string', 15), 'please cut here');
      expect('please cut'.cut(15), 'please cut');
      expect(cut('please cut', 15), 'please cut');
      //expect(cut(null, 15), null);
      //String test;
      //expect(test?.cut(3), null);
    });

    test('Cut error', () {
      //expect(() => null.cut(15), throwsNoSuchMethodError);
      expect(() => 'please cut'.cut(-1), throwsRangeError);
    });
  });

  group('Cut And Align', () {
    setUp(() {});

    test('Cut And Align ok', () {
      expect('please cut here this string'.cutAndAlign(15), 'please cut here');
      expect(
          'please cut here this string'
              .cutAndAlign(15, leftAlign: false, paddingChar: '*'),
          'please cut here');
      expect('please cut'.cutAndAlign(15), 'please cut     ');
      expect('please cut'.cutAndAlign(15, leftAlign: false), '     please cut');
      expect('please cut'.cutAndAlign(15, paddingChar: '*'), 'please cut*****');
      expect('please cut'.cutAndAlign(15, leftAlign: false, paddingChar: '*'),
          '*****please cut');
    });

    test('Cut and Align error', () {
      //expect(() => null.cutAndAlign(15), throwsNoSuchMethodError);
      expect(
          () =>
              'please cut'.cutAndAlign(-1, leftAlign: false, paddingChar: '*'),
          throwsRangeError);
    });
  });

  group('Preserve only Chars', () {
    setUp(() {});

    test('Preserve only chars ok', () {
      expect('5,769.34'.preserveOnlyChars('0123456789'), '576934');
      expect('5,769.34'.preserveOnlyChars('0123456789', replacementChar: ' '),
          '5 769 34');
      expect('5,769.34'.preserveOnlyChars(''), '');
      expect('5,769.34'.preserveOnlyChars('0123456789', replacementChar: null),
          '576934');

      expect(preserveOnlyChars('5,769.34', '0123456789'), '576934');
      expect(preserveOnlyChars('5,769.34', '0123456789', replacementChar: ' '),
          '5 769 34');
    });

    /*  test('Preserve only chars error', () {
      expect(
              () => null.preserveOnlyChars('0123456789'), throwsNoSuchMethodError);
      expect(() => '5,769.34'.preserveOnlyChars(null), throwsArgumentError);
    }); */
  });

  group('A group of tests', () {
    setUp(() {});

    test('Capitalize traditional', () {
      expect(capitalizeAndLowercase('main'), 'Main');
      //expect(capitalizeAndLowercase(null), isEmpty);
      expect(capitalizeAndLowercase(''), isEmpty);
      expect(capitalizeAndLowercase('m'), 'M');
      expect(capitalizeAndLowercase('M'), 'M');
      expect(capitalizeAndLowercase('i'), 'I');
      expect(capitalizeAndLowercase('THETA'), 'Theta');
      expect(capitalizeAndLowercase('jOhN'), 'John');
    });

    test('Capitalize', () {
      expect('main'.capitalizeAndLowercase(), 'Main');
      expect(''.capitalizeAndLowercase(), isEmpty);
      expect('m'.capitalizeAndLowercase(), 'M');
      expect('M'.capitalizeAndLowercase(), 'M');
      expect('i'.capitalizeAndLowercase(), 'I');
      expect('THETA'.capitalizeAndLowercase(), 'Theta');
      expect('jOhN'.capitalizeAndLowercase(), 'John');
      //expect(() => null.capitalize(), throwsNoSuchMethodError);

      expect('main'.capitalizeRestUnchanged(), 'Main');
      expect(''.capitalizeRestUnchanged(), isEmpty);
      expect('m'.capitalizeRestUnchanged(), 'M');
      expect('M'.capitalizeRestUnchanged(), 'M');
      expect('i'.capitalizeRestUnchanged(), 'I');
      expect('THETA'.capitalizeRestUnchanged(), 'THETA');
      expect('jOhN'.capitalizeRestUnchanged(), 'JOhN');
    });

    test('Uncapitalize', () {
      expect('Main'.uncapitalizeRestUnchanged(), 'main');
      expect(''.uncapitalizeRestUnchanged(), isEmpty);
      expect('M'.uncapitalizeRestUnchanged(), 'm');
      expect('m'.uncapitalizeRestUnchanged(), 'm');
      expect('I'.uncapitalizeRestUnchanged(), 'i');
      expect('THETA'.uncapitalizeRestUnchanged(), 'tHETA');
      expect('JOhN'.uncapitalizeRestUnchanged(), 'jOhN');
    });

    test('Empty or null', () {
      expect(unfilled(null), isTrue);
      expect(unfilled(''), isTrue);
      expect(unfilled('g'), isFalse);
      expect(unfilled('verify'), isFalse);
    });

    test('Only digits', () {
      expect(onlyContainsDigits('Value'), isFalse);
      //expect(onlyContainsDigits(null), isFalse);
      expect(onlyContainsDigits(''), isFalse);
      expect(onlyContainsDigits('A234'), isFalse);
      expect(onlyContainsDigits('2712b'), isFalse);
      expect(onlyContainsDigits('12T24'), isFalse);
      expect(onlyContainsDigits('27-12'), isFalse);
      expect(onlyContainsDigits('1953'), isTrue);
    });
    test('Only alpha', () {
      expect(onlyContainsAlpha('Value'), isTrue);
      //expect(onlyContainsAlpha(null), isFalse);
      expect(onlyContainsAlpha(''), isFalse);
      expect(onlyContainsAlpha('A234'), isFalse);
      expect(onlyContainsAlpha('2712b'), isFalse);
      expect(onlyContainsAlpha('12T24'), isFalse);
      expect(onlyContainsAlpha('27-12'), isFalse);
      expect(onlyContainsAlpha('1953'), isFalse);
      expect(onlyContainsAlpha('en_US'), isFalse);
    });
    test('Dart Identifier', () {
      final source = '''
      enum _LanguageType{ dart, cPlusPlus, c, java, python}
      ''';

      expect(isDartIdentifier(source, 12), isTrue);
      expect(isDartIdentifier(source, 11), isTrue);
      expect(isDartIdentifier(source, 10), isFalse);
      expect(source.isDartIdentifier(12), isTrue);
      expect(source.isDartIdentifier(11), isTrue);
      expect(source.isDartIdentifier(10), isFalse);

      expect(getDartIdentifier(source, 10), '');
      expect(getDartIdentifier(source, 11), '_LanguageType');
      expect(getDartIdentifier(source, 12), 'LanguageType');
      expect(source.getDartIdentifier(10), '');
      expect(source.getDartIdentifier(11), '_LanguageType');
      expect(source.getDartIdentifier(12), 'LanguageType');
    });
    test('Dart Annotation Identifier', () {
      final source = '''
           @Annotate('Test note')
      ''';

      expect(isDartAnnotation(source, 12), isFalse);
      expect(isDartAnnotation(source, 11), isTrue);
      expect(isDartAnnotation(source, 10), isFalse);

      expect(getDartAnnotationIdentifier(source, 10), '');
      expect(getDartAnnotationIdentifier(source, 11), 'Annotate');
      expect(getDartAnnotationIdentifier(source, 12), '');
    });

    test('SplitInLines', () {
      final test = 'Lorem ipsum dolor sit amet, consectetur adipisci elit, '
          'sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrum exercitationem ullamco '
          'laboriosam, nisi ut aliquid ex ea commodi consequatur. '
          'Duis aute irure reprehenderit in voluptate velit esse cillum '
          'dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat '
          'non proident, sunt in culpa qui officia deserunt mollit anim '
          'id est laborum.';
      // ignore: omit_local_variable_types
      List<String> parts = splitInLines(test, 50);
      expect(parts.length, 10);
      expect(parts.first, 'Lorem ipsum dolor sit amet, consectetur adipisci ');
      expect(parts[5], 'aute irure reprehenderit in voluptate velit esse ');
      expect(parts.last, 'laborum.');
      // ignore: omit_local_variable_types
      List<String> extParts = test.splitInLines(50);
      expect(parts.length, extParts.length);
      expect(parts.first, extParts.first);
      expect(parts[5], extParts[5]);
      expect(parts.last, extParts.last);
      // ignore: omit_local_variable_types
      List<String> parts1 = splitInLines(test, 50, separator: ',');
      expect(parts1.length, 11);
      expect(parts1.first, 'Lorem ipsum dolor sit amet,');
      expect(parts1[2], ' sed do eiusmod tempor incidunt ut labore et dolor');
      expect(parts1[3], 'e magna aliqua. Ut enim ad minim veniam,');
      expect(parts1.last, ' est laborum.');
      // ignore: omit_local_variable_types
      List<String> parts2 = test.splitInLines(50, firstLineDecrease: 12);
      expect(parts2.length, 10);
      expect(parts2.first, 'Lorem ipsum dolor sit amet, ');
      expect(parts2[5], 'consequatur. Duis aute irure reprehenderit in ');
      expect(parts2.last, 'mollit anim id est laborum.');
      expect(test, parts.join());
      expect(parts.join(), parts1.join());
      expect(parts.join(), parts2.join());
    });
    test('SplitInLines 1', () {
      const test1 = 'consequatur';
      // ignore: omit_local_variable_types
      List<String> parts1 = splitInLines(test1, 10);
      expect(parts1.length, 2);
      expect(parts1.first, 'consequatu');
      expect(parts1.last, 'r');
      // ignore: omit_local_variable_types
      List<String> parts2 = splitInLines(test1, 11);
      expect(parts2.length, 1);
      expect(parts2.first, 'consequatur');
      // ignore: omit_local_variable_types
      List<String> parts3 = splitInLines(test1, 12);
      expect(parts3.length, 1);
      expect(parts3.first, 'consequatur');
      const test = 'Lorem amet';
      // ignore: omit_local_variable_types
      List<String> parts = splitInLines(test, 10);
      expect(parts.length, 1);
      expect(parts.first, 'Lorem amet');
    });

    test('SplitInLines 2', () {
      const test1 = 'consequatur mollit est';
      // ignore: omit_local_variable_types
      List<String> parts1 = splitInLines(test1, 10);
      expect(parts1.length, 3);
      expect(parts1.first, 'consequatu');
      expect(parts1[1], 'r mollit ');
      expect(parts1.last, 'est');
      // ignore: omit_local_variable_types
      List<String> parts2 = splitInLines(test1, 11);
      expect(parts2.length, 2);
      expect(parts2.first, 'consequatur');
      expect(parts2.last, ' mollit est');
      // ignore: omit_local_variable_types
      List<String> parts3 = splitInLines(test1, 12);
      expect(parts3.length, 2);
      expect(parts3.first, 'consequatur ');
      expect(parts3.last, 'mollit est');
      expect(test1, parts1.join());
      expect(test1, parts2.join());
      expect(test1, parts3.join());
    });

    test('SplitInLines 3', () {
      const test1 = 'mollit est consequatur';
      // ignore: omit_local_variable_types
      List<String> parts1 = splitInLines(test1, 10);
      expect(parts1.length, 4);
      expect(parts1.first, 'mollit ');
      expect(parts1[1], 'est ');
      expect(parts1[2], 'consequatu');
      expect(parts1.last, 'r');
      // ignore: omit_local_variable_types
      List<String> parts2 = splitInLines(test1, 11);
      expect(parts2.length, 2);
      expect(parts2.first, 'mollit est ');
      expect(parts2.last, 'consequatur');
      // ignore: omit_local_variable_types
      List<String> parts4 = splitInLines(test1, 11, firstLineDecrease: 5);
      expect(parts4.length, 3);
      expect(parts4.first, 'mollit');
      expect(parts4[1], ' est ');
      expect(parts4.last, 'consequatur');
      // ignore: omit_local_variable_types
      List<String> parts3 = splitInLines(test1, 12);
      expect(parts3.length, 2);
      expect(parts3.first, 'mollit est ');
      expect(parts3.last, 'consequatur');
      expect(test1, parts1.join());
      expect(test1, parts2.join());
      expect(test1, parts3.join());
      expect(test1, parts4.join());
    });
  });
}
