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
String cut(String string, int length) {
  if (string == null) {
    return string;
  }
  if (string.length <= length) {
    return string;
  }
  return string.substring(0, length);
  //return string.cut(length);
}

String cutAndAlign(String string, int newLength,
    {String paddingChar, bool leftAlign}) {
  paddingChar ??= ' ';
  leftAlign ??= true;
  String ret = cut(string, newLength);
  if (leftAlign) {
    return ret.padRight(newLength, paddingChar);
  } else {
    return ret.padLeft(newLength, paddingChar);
  }
}

List<String> splitInLines(String string, int lineLength,
    {String separator, int firstLineDecrease}) {
  separator ??= ' ';
  firstLineDecrease ??= 0;
  final StringBuffer buffer = StringBuffer();
  final List<String> ret = <String>[];
  if (String == null) {
    return ret;
  }

  final List<String> parts = string.split(separator);
  int length = lineLength - firstLineDecrease;
  for (String part in parts) {
    if (buffer.length +
            part.length +
            (part == parts.last ? 0 : separator.length) >
        length) {
      if (buffer.isNotEmpty) {
        ret.add('$buffer');
        buffer.clear();
        length = lineLength;
      }
    }

    int idx = 0;
    if (part == parts.last) {
      for (; idx + length < part.length; idx += length) {
        buffer.write(part.substring(idx, idx + length));
        ret.add('$buffer');
        buffer.clear();
        length = lineLength;
      }
      buffer.write(part.substring(idx));
    } else {
      for (; idx + length < part.length + separator.length; idx += length) {
        buffer.write(part.substring(idx, idx + length));
        ret.add('$buffer');
        buffer.clear();
        length = lineLength;
      }
      buffer.write(part.substring(idx));
      buffer.write(separator);
    }
  }
  return ret..add('$buffer');
}

@Deprecated('Use preserveOnlyChars instead (wrong name)')
String clearUnrequestedChars(String string, String validChars,
    {String replacementChar}) {
  replacementChar ??= '';
  final StringBuffer buffer = StringBuffer();
  for (int idx = 0; idx < string.length; idx++) {
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

String preserveOnlyChars(String string, String validChars,
    {String replacementChar}) {
  replacementChar ??= '';
  final StringBuffer buffer = StringBuffer();
  for (int idx = 0; idx < string.length; idx++) {
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

String capitalize(String string) {
  if (unfilled(string)) {
    return '';
  }
  if (string.length == 1) {
    return string.toUpperCase();
  }
  StringBuffer buffer = StringBuffer()
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
