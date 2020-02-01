import 'package:test/test.dart';

/// Test Line1
/// Test line2
// standard comment
/*block comment */

void main() {
  Testing t = Testing('''Bit''');
  print(t.string3);
}
/// Class description
class Testing {
  String string1 = "Alpha";
  // unit msg
  String string2 = 'Beta';
  /* block comment
     more lines
  */
  String string3= '''' prova check 
  "prova chek2" 'Check 3'
  "''';

  int edit = 5;

  bool get testBool => true;

  Testing(String detail) {
    string1 = detail;
  }

  void checkString() {
    /*  //  value /// doesNotComplete "}
    '''(
    */
    // /*  '  */
    var list = <String>[];
    print('Boh');
  }
}
