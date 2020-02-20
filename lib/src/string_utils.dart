import 'package:vy_string_utils/src/reg_exp.dart'
    show onlyAlphaCharsRegExp, onlyDigitsRegExp;
import 'package:vy_string_utils/src/reg_exp.dart';

import 'string_extension.dart';

/// Cuts the String to the required length starting from the beginning
///
/// This method works approximately like the substring one, with the difference
/// that, if the string length is lesser than the length required
/// the string is returned unchanged instead of throwing error
/// If the string is null, null is returned
String cut(String string, int length) => string?.cut(length);

/// Cuts the String and, if lesser then required, aligns  it
/// padding the exceeding chars to the right or to the left
/// with the character selected.
String cutAndAlign(String string, int newLength,
        {String paddingChar, bool leftAlign}) =>
    string.cutAndAlign(newLength,
        paddingChar: paddingChar, leftAlign: leftAlign);

/// Divides a String in lines of the length required.
/// The default separator is blank, but it can be set a different char
/// It is possible to set a different length for the first line.
List<String> splitInLines(String string, int lineLength,
        {String separator, int firstLineDecrease}) =>
    string?.splitInLines(lineLength,
        separator: separator, firstLineDecrease: firstLineDecrease) ??
    <String>[];

@Deprecated('Use preserveOnlyChars instead (wrong name)')
String clearUnrequestedChars(String string, String validChars,
    {String replacementChar}) {
  replacementChar ??= '';
  final buffer = StringBuffer();
  for (var idx = 0; idx < string.length; idx++) {
    if (validChars.contains(string[idx])) {
      buffer.write(string[idx]);
    } else {
      if (replacementChar.isNotEmpty) {
        buffer.write(replacementChar);
      }
    }
  }
  return buffer.toString();
}

/// Returns a String that is made of some required chars only.
/// Optionally the removed characters can be substituted with
/// a replacement char
String preserveOnlyChars(String string, String validChars,
        {String replacementChar}) =>
    string.preserveOnlyChars(validChars, replacementChar: replacementChar);

/// Capitalize the first character of the string and
/// lowercase the others (using toUpperCase() and
/// toLowerCase() respectively).
String capitalize(String string) {
  if (unfilled(string)) {
    return '';
  }
  if (string.length == 1) {
    return string.toUpperCase();
  }
  final buffer = StringBuffer()
    ..write(string[0].toUpperCase())
    ..write(string.substring(1, string.length).toLowerCase());
  return '$buffer';
}

bool unfilled(String string) => string?.isEmpty ?? true;

bool filled(String string) => !unfilled(string);

bool onlyContainsDigits(String string) =>
    filled(string) && string.contains(onlyDigitsRegExp);

bool onlyContainsAlpha(String string) =>
    filled(string) && string.contains(onlyAlphaCharsRegExp);

bool isDartIdentifier(String source, int startPosition) =>
    source.startsWith(dartIdentifierRegExp, startPosition ?? 0);

String getDartIdentifier(String source, int startPosition) =>
    dartIdentifierRegExp.matchAsPrefix(source, startPosition)?.group(0) ?? '';

bool isDartAnnotation(String source, int startPosition) =>
    source.startsWith(dartAnnotationRegExp, startPosition ?? 0);

String getDartAnnotationIdentifier(String source, int startPosition) =>
    dartAnnotationRegExp
        .matchAsPrefix(source, startPosition)
        ?.group(0)
        ?.substring(1) ??
    '';
