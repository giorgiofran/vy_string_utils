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

List<String> splitInLines(String string, int lineLength, {String separator}) {
  separator ??= ' ';
  final StringBuffer buffer = StringBuffer();
  final List<String> ret = <String>[];
  final int length = lineLength - 3;
  if (String == null) {
    return ret;
  }

  final List<String> parts = string.split(separator);
  for (String part in parts) {
    if (buffer.length + part.length > length - 3) {
      if (buffer.isNotEmpty) {
        ret.add(cut(buffer.toString(), lineLength));
        buffer.clear();
      }
    }
    if (part == parts.last) {
      buffer.write(part);
    } else {
      buffer.write('$part$separator');
    }
  }
  return ret..add(cut(buffer.toString(), lineLength));
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
