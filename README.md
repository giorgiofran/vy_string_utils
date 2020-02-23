A collection of string utilities.

These utilities simplifies some formatting needs.
The main methods are:
- cut() -> Cuts a String at the required length if bigger or returns the origin otherwise.
- cutAndAlign() -> Cuts a String or pads it right or left with a certain character 
  to the required length if needed
- preserveOnlyChars() -> returns a String containing only the required characters. 
  Optionally the removed characters can be substituted by a placeholder.  
- splitInLines() -> split a sentence in lines of the required length based on a given separator.
- capitalize() -> Capitalize the first character of the string and lowercase the others.
- onlyContainsDigits() -> returns true if the string contains only digits.
- onlyContainsAlpha() -> returns true if the string only contains alpha characters (RegExp [a-zA-Z]) 
- isDartIdentifier() -> returns true if the characters starting at the given position are a valid Dart 
  identifier.
- getDartIdentifier() -> return the valid Dart identifier (if any) at certain position in a 
  source string.   
  
  All these methods are presented also as extensions.
  
[license](https://github.com/giorgiofran/vy_string_utils/blob/master/CHANGELOG.md).

## Usage

A simple usage example:

```dart
import 'package:vy_string_utils/vy_string_utils.dart';

main() {
  print('please cut'.cutAndAlign(15, paddingChar: '*')); // 'please cut*****'

  print('main'.capitalize()); // 'Main'

  print('1953'.onlyContainsDigits()); // true
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/giorgiofran/vy_string_utils/issues
