import 'package:vy_string_utils/vy_string_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Formatter', () {
    test('DateTime', () {
      var timeTest = DateTime(2020, 4, 5, 15, 45, 30, 513);
      expect(dateTimeUpToSeconds(timeTest), '2020-04-05 15:45:30');
    });
  });
}
