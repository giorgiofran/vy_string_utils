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
  });
}
