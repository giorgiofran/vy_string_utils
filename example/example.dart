/// Copyright © 2020 Giorgio Franceschetti. All rights reserved.

import 'package:vy_string_utils/vy_string_utils.dart';

void main() {
  print('please cut here this string'.cut(15)); //'please cut here'
  print('please cut'.cut(15)); // 'please cut'

  print('please cut here this string'.cutAndAlign(15)); // 'please cut here'

  print('please cut'.cutAndAlign(15)); // 'please cut     '
  print('please cut'.cutAndAlign(15, leftAlign: false)); // '     please cut'
  print('please cut'.cutAndAlign(15, paddingChar: '*')); // 'please cut*****'
  print('please cut'.cutAndAlign(15,
      leftAlign: false, paddingChar: '*')); //   '*****please cut'

  print('5,769.34'.preserveOnlyChars('0123456789')); // '576934'
  print('5,769.34'
      .preserveOnlyChars('0123456789', replacementChar: ' ')); // '5 769 34'

  print('main'.capitalizeAndLowercase()); // 'Main'
  print('THETA'.capitalizeAndLowercase()); // 'Theta'
  print('jOhN'.capitalizeAndLowercase()); // 'John'

  print(unfilled(null)); // true
  print(unfilled('')); // true
  print(unfilled('verify')); // false

  print(filled(null)); // false
  print(filled('')); // false
  print(filled('verify')); // true

  print('27-12'.onlyContainsDigits()); // false
  print('1953'.onlyContainsDigits()); // true

  print(onlyContainsAlpha('Value')); //  true
  print(onlyContainsAlpha('en_US')); // false

  List<String> parts;
  parts = 'mollit est consequatur'.splitInLines(11);
  print(parts.length); // 2
  print(parts.first); // 'mollit est '
  print(parts.last); // 'consequatur'
}
