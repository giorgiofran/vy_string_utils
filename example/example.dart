import 'package:vy_string_utils/vy_string_utils.dart';

void main() {
  print('please cut here this string'.cut(15)); //'please cut here')
  print(cut('please cut here this string', 15)); // 'please cut here'
  print('please cut'.cut(15)); // 'please cut'
  print(cut('please cut', 15)); // 'please cut'
  print(cut(null, 15)); // null;
  String nullString;
  print(nullString?.cut(15)); // null;
}
