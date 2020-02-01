import 'package:vy_string_utils/src/source_utils.dart';

import 'dart_elements/dart_annotation.dart';

enum ContentType {
  docComment,
  singleComment,
  blockComment,
  singleQuoteText,
  rawSingleQuoteText,
  doubleQuoteText,
  rawDoubleQuoeText,
  multiLineText,
  rawMultiLineText,
  parentheses,
  squareBrackets,
  curlyBrackets,
  statement
}

class Content {
  final ContentType type;
  final String content;
  final int sourceStartContent;
  final int sourceEndContent;
  final int startPosition;
  final int startContent;
  final int endContent;
  final int endPosition;
  final int level;

  Content(
      this.type,
      this.sourceStartContent,
      this.sourceEndContent,
      this.content,
      this.startPosition,
      this.startContent,
      this.endContent,
      this.endPosition,
      {this.level});

  String sourceContent(String source) =>
      source.substring(sourceStartContent, sourceEndContent).trimLeft();
  String rawSourceContent(String source) =>
      source.substring(sourceStartContent, sourceEndContent);
  String targetContent(String target) =>
      target.substring(startContent, endContent).trimLeft();
  String rawTargetContent(String target) =>
      target.substring(startContent, endContent);
  String wholeTargetContent(String target) =>
      target.substring(startPosition, endPosition);
}

class Comment extends Content {
  CommentBehavior behavior;
  Comment(
      ContentType type,
      this.behavior,
      int sourceStartContent,
      int sourceEndContent,
      String content,
      int startPosition,
      int startContent,
      int endContent,
      int endPosition)
      : super(type, sourceStartContent, sourceEndContent, content,
            startPosition, startContent, endContent, endPosition);

  String rawTargetContent(String target) {
    if (behavior != CommentBehavior.preserve) {
      throw StateError('The comment has been removed from the target source. '
          'Cannot return a value.');
    }
    return super.rawTargetContent(target);
  }

  String wholeTargetContent(String target) {
    if (behavior != CommentBehavior.preserve) {
      throw StateError('The comment has been removed from the target source. '
          'Cannot return a value.');
    }
    return super.wholeTargetContent(target);
  }
}

class Statement extends Content {
  List<Statement> statements = <Statement>[];
  Statement(String content, int sourceStartContent, int sourceEndContent,
      int startPosition, int startContent, int endContent, int endPosition,
      {int level})
      : super(ContentType.statement, sourceStartContent, sourceEndContent,
            content, startPosition, startContent, endContent, endPosition,
            level: level);

  bool get isCompoundStatement => statements.isNotEmpty;
}

class AnalysisResult {
  final String source;
  final List<Content> comments;
  final List<Content> texts;
  final List<Content> blocks;
  final List<Statement> statements;
  final List<DartAnnotation> annotations;

  AnalysisResult(this.source, this.comments, this.texts, this.blocks,
      this.statements, this.annotations);
}
