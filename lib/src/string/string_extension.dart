/// Copyright © 2020 Giorgio Franceschetti. All rights reserved.

import 'package:vy_string_utils/src/reg_exp.dart';

extension StringExtension on String {
  /// Cuts the String to the required length starting from the beginning
  ///
  /// This method works approximately like the substring one, with the difference
  /// that, if the string length is lesser than the length required
  /// the string is returned unchanged instead of throwing error
  ///
  /// Example: 'Cut This'.cut(3)  returns 'Cut'
  ///          'Cut This'.cut(10) returns 'Cut This'
  ///
  /// The method only works from the beginning of the string
  String cut(int newLength) {
    if (length <= newLength) {
      return this;
    }
    return substring(0, newLength);
  }

  /// Cuts the String and, if lesser then required, aligns  it
  /// padding the exceeding chars to the right or to the left
  /// with the character selected.
  ///
  /// Example: 'Cut This'.cutAndAlign(3)  returns 'Cut'
  ///          'Cut This'.cutAndAlign(10) returns 'Cut This  '
  ///          'Cut This'.cutAndAlign(10, paddingChar: '*') returns 'Cut This**'
  ///          'Cut This'.cutAndAlign(10, paddingChar: '*',
  ///               leftAlign: false) returns '**Cut This'
  ///
  /// The method only works from the beginning of the string
  String cutAndAlign(int newLength, {String? paddingChar, bool? leftAlign}) {
    paddingChar ??= ' ';
    leftAlign ??= true;
    final ret = cut(newLength);
    if (leftAlign) {
      return ret.padRight(newLength, paddingChar);
    } else {
      return ret.padLeft(newLength, paddingChar);
    }
  }

  /// Returns a String that is made of some required chars only.
  /// Optionally the removed characters can be substituted with
  /// a replacement char
  ///
  /// Example: '5,3798.00'.preserveOnlyChars('0123456789') returns '5379800'
  ///          '5,3798.00'.preserveOnlyChars('0123456789', replacementChar: ' ') returns '5 3798 00'
  String preserveOnlyChars(String validChars, {String? replacementChar}) {
    /*    if (validChars == null) {
      throw ArgumentError('The validChar parameter cannot be null');
    } */
    replacementChar ??= '';
    final buffer = StringBuffer();
    for (var idx = 0; idx < length; idx++) {
      if (validChars.contains(this[idx])) {
        buffer.write(this[idx]);
      } else {
        if (replacementChar.isNotEmpty) {
          buffer.write(replacementChar);
        }
      }
    }
    return buffer.toString();
  }

  /// Divides a String in lines of the length required.
  /// The default separator is blank, but it can be set a different char
  /// It is possible to set a different length for the first line.
  ///
  /// Example:
  ///     'consequatur mollit est'.splitInLines(11) returns
  ///     ['consequatur', ' mollit est']

  List<String> splitInLines(int lineLength,
      {String? separator, int? firstLineDecrease}) {
    separator ??= ' ';
    firstLineDecrease ??= 0;
    final buffer = StringBuffer();
    final ret = <String>[];
    var requiredLength = lineLength - firstLineDecrease;

    void _writeAndFlushBuffer({String? addString}) {
      if (addString != null) {
        buffer.write(addString);
      }
      if (buffer.isNotEmpty) {
        ret.add('$buffer');
        buffer.clear();
        requiredLength = lineLength;
      }
    }

    if (requiredLength < 1) {
      _writeAndFlushBuffer(addString: ' ');
    }

    final parts = split(separator);
    for (var part in parts) {
      if (buffer.length +
              part.length +
              (part == parts.last ? 0 : separator.length) >
          requiredLength) {
        _writeAndFlushBuffer();
      }

      var idx = 0;
      if (part == parts.last) {
        for (; idx + requiredLength < part.length; idx += requiredLength) {
          _writeAndFlushBuffer(
              addString: part.substring(idx, idx + requiredLength));
        }
        if (idx < part.length) {
          buffer.write(part.substring(idx));
        }
      } else {
        for (;
            idx + requiredLength < part.length + separator.length;
            idx += requiredLength) {
          _writeAndFlushBuffer(
              addString: part.substring(idx, idx + requiredLength));
        }
        if (idx < part.length) {
          buffer.write(part.substring(idx));
        }
        buffer.write(separator);
      }
    }
    return ret..add('$buffer');
  }

  /// Capitalize the first character of the string and
  /// lowercase the others (using toUpperCase() and
  /// toLowerCase() respectively).
  String capitalizeAndLowercase() => [
        if (isNotEmpty) this[0].toUpperCase(),
        if (length > 1) substring(1, length).toLowerCase()
      ].join();

  /// Capitalize the first character of any word in the string string and
  /// lowercase the others (using toUpperCase() and
  /// toLowerCase() respectively).
  /// The method also execute am implicit trim() on the atring
  String capitalizeAndLowercaseAnyWord() => [
        for (var part in trim().split(' ')) part.capitalizeAndLowercase()
      ].join(' ');

  /// Capitalize the first character of the string and
  /// leaves the rest as is.
  /// In a future release will be called only capitalize
  String capitalizeRestUnchanged() => [
        if (isNotEmpty) this[0].toUpperCase(),
        if (length > 1) substring(1, length)
      ].join();

  /// Uncapitalize the first character of the string and
  /// leaves the rest as is.
  /// In a future release will be called only uncapitalize
  String uncapitalizeRestUnchanged() => [
        if (isNotEmpty) this[0].toLowerCase(),
        if (length > 1) substring(1, length)
      ].join();

  @Deprecated('Use capitalizeAndLowercase instead.')
  String capitalize() => capitalizeAndLowercase();

  /// A convenient way for checking if there are only digits.
  bool onlyContainsDigits() => isNotEmpty && contains(onlyDigitsRegExp);

  /// A convenient way for checking if there are only alpha chars ([a-zA-Z]).
  bool onlyContainsAlpha() => isNotEmpty && contains(onlyAlphaCharsRegExp);

  /// Verifies if the content of one source string in a certain position
  /// is a Dart identifier.
  bool isDartIdentifier(int startPosition) =>
      isNotEmpty && startsWith(dartIdentifierRegExp, startPosition);

  /// Extracts the identifier (if present) from a source string
  /// in a certain position.
  String getDartIdentifier(int startPosition) =>
      dartIdentifierRegExp.matchAsPrefix(this, startPosition)?.group(0) ?? '';

  /// Returns true if this string starts and ends with the same given string
  /// If whitespaces can be present is better to execute first a trim()
  /// call.
  bool startsAndEndsWith(String delimiter) {
    if (startsWith(delimiter) && endsWith(delimiter)) {
      return true;
    }
    return false;
  }

  /// Removes the given delimiters (if present) from the string
  String trimDelimiters(String delimiter) {
    if (startsAndEndsWith(delimiter)) {
      return substring(delimiter.length, length - delimiter.length);
    }
    return this;
  }

  /// Removes String delimiters if present (only the outer ones);
  String trimStringDelimiters() {
    if (startsAndEndsWith("'''")) {
      return substring(3, length - 3);
    } else if (startsAndEndsWith("'") || startsAndEndsWith('"')) {
      return substring(1, length - 1);
    }
    return this;
  }
}
