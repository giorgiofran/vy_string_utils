import 'package:vy_string_utils/src/string_utils.dart';

import '../support_classes.dart';

class DartAnnotation extends Statement {
  String identifier;

  DartAnnotation(String content, int sourceStartContent, int sourceEndContent,
      int startPosition, int startContent, int endContent, int endPosition)
      : super(content, sourceStartContent, sourceEndContent, startPosition,
            startContent, endContent, endPosition) {
    identifier = getDartIdentifier(content, 0);
  }
}
