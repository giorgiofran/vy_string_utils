// Single line format comment (//)
// Block comment (/* ….. */)
// Doc comment (///)

import 'package:vy_string_utils/src/string_utils.dart';
import 'package:vy_string_utils/src/support_classes.dart';

import 'dart_elements/dart_annotation.dart';

enum CommentBehavior { splitAndLose, splitAndLog, preserve }

const String escapeToken = r'\';
const String singleCommentToken = '//';
const String docCommentToken = '///';
const String blockCommentStartToken = '/*';
const String blockCommentEndToken = '*/';
const String lineCommentEndLong = '\r\n';
const String lineCommentEnd = '\n';
const String lineCommentEndOld = '\r';

const String singleQuoteText = "'";
const String rawSingleQuoteText = "r'";
const String singleQuoteTextEnd = "'";
const String doubleQuoteText = '"';
const String rawDoubleQuoteText = 'r"';
const String doubleQuoteTextEnd = '"';
const String multiLineText = "'''";
const String rawMultiLineText = "r'''";
const String multiLineTextEnd = "'''";
const String blockStartToken = '{';
const String blockEndDefinitionToken = '})';
const String blockEndToken = '}';
const String parenthesesStartToken = '(';
const String parenthesesEndToken = ')';
const String statementDelimiterToken = ';';

AnalysisResult analyzeDartSourceBasic(
    String source,
    CommentBehavior singleCommentBehavior,
    CommentBehavior blockCommentBehavior,
    CommentBehavior docCommentBehavior) {
  bool modifySource = singleCommentBehavior != CommentBehavior.preserve ||
      blockCommentBehavior != CommentBehavior.preserve ||
      docCommentBehavior != CommentBehavior.preserve;

  StringBuffer buffer;
  if (modifySource) {
    buffer = StringBuffer();
  }

  List<Content> comments = <Content>[];
  List<Content> texts = <Content>[];
  List<Content> blocks = <Content>[]; // curly
  // Todo At present does not work
  List<Statement> statements = <Statement>[];
  List<DartAnnotation> annotations = <DartAnnotation>[];

  List<Map<PositionInfo, ContentType>> blockLevels =
      <Map<PositionInfo, ContentType>>[];
  List<PositionInfo> statementLevels = <PositionInfo>[PositionInfo(0, 0, 0)];
  ContentType openCommentType, openTextType;
  bool isCommentOpen() => openCommentType != null;
  bool isTextOpen() => openTextType != null;
  bool isBlockOpen() => blockLevels.isNotEmpty;
  bool escapeActive = false;

  PositionInfo startPositionInfo;
  int skipCharUpTo = 0;
  int lastStatement = 0;
  Map<PositionInfo, int> annotationStartPosition;

  bool isAnnotationOpen({int level}) =>
      annotationStartPosition != null &&
      (level == null || annotationStartPosition.values.first == level);

  for (int idx = 0; idx < source.length; idx++) {
    CommentBehavior commentBehavior;

    int sourceStartPosition() => idx;
    int sourceStartContent(String token) => idx + token?.length ?? 0;
    int targetStartPosition() =>
        modifySource ? buffer.length : sourceStartPosition();
    int targetStartContent(String token) =>
        targetStartPosition() + token?.length ?? 0;

    int sourceEndContent() => sourceStartPosition();
    int sourceEndPosition(String token) =>
        sourceEndContent() + token?.length ?? 0;
    int targetEndContent() => targetStartPosition();
    int targetEndPosition(String token) =>
        targetEndContent() + token?.length ?? 0;
    Content _createContent(
        ContentType contentType, String endToken, PositionInfo info,
        {int sourceContentEnd, int targetContentEnd, int targetPositionEnd}) {
      try {
        return Content(
            contentType,
            info.sourcePlusToken,
            sourceContentEnd ?? sourceEndContent(),
            source.substring(
                info.sourcePlusToken, sourceContentEnd ?? sourceEndContent()),
            info.targetIndex,
            info.targetPlusToken,
            targetContentEnd ?? targetEndContent(),
            targetPositionEnd ?? targetEndPosition(endToken));
      } catch (e) {
        print('$e, ${info.sourcePlusToken} - ${sourceContentEnd}');
        rethrow;
      }
    }

    Content _createComment(ContentType contentType,
        CommentBehavior commentBehavior, String endToken, PositionInfo info,
        {int sourceContentEnd, int targetContentEnd, int targetPositionEnd}) {
      try {
        return Comment(
            contentType,
            commentBehavior,
            info.sourcePlusToken,
            sourceContentEnd ?? sourceEndContent(),
            source.substring(
                info.sourcePlusToken, sourceContentEnd ?? sourceEndContent()),
            info.targetIndex,
            commentBehavior == CommentBehavior.preserve
                ? info.targetPlusToken
                : info.targetIndex,
            targetContentEnd ?? targetEndContent(),
            targetPositionEnd ?? targetEndPosition(endToken));
      } catch (e) {
        print('$e, ${info.sourcePlusToken} - ${sourceContentEnd}');
        rethrow;
      }
    }

    void _closeStatement(String token, {bool considerCurrentEndToken}) {
      considerCurrentEndToken ??= false;
      Statement statement;
      int blockLevel = 0;
      for (int idx = blockLevels.length; idx > 0;) {
        idx--;
        if (blockLevels[idx].values.first == ContentType.curlyBrackets) {
          blockLevel = idx + 1;
          break;
        }
      }
      PositionInfo info = statementLevels[blockLevel];
      if (info == null) {
        print('${blockLevels}, ${statementLevels}');
      }
      statement = Statement(
          source.substring(
              info.sourcePlusToken,
              considerCurrentEndToken
                  ? sourceEndPosition(token)
                  : sourceEndContent()),
          info.sourcePlusToken,
          considerCurrentEndToken
              ? sourceEndPosition(token)
              : sourceEndContent(),
          info.targetIndex,
          info.targetPlusToken,
          considerCurrentEndToken
              ? targetEndPosition(token)
              : targetEndContent(),
          targetEndPosition(token),
          level: blockLevel);
      while (statements.isNotEmpty && statement.level < statements.last.level) {
        if (statement.statements.isEmpty) {
          statement.statements.add(statements.last);
        } else {
          statement.statements.insert(0, statements.last);
        }
        statements.removeLast();
      }

      statements.add(statement);
      statementLevels[blockLevel] =
          PositionInfo(sourceEndPosition(token), targetEndPosition(token), 0);
    }

    if (isCommentOpen()) {
      ContentType contentType;
      List<String> tokens;
      contentType = openCommentType;
      if (openCommentType == ContentType.singleComment) {
        tokens = <String>[
          lineCommentEndLong,
          lineCommentEndLong,
          lineCommentEnd
        ];
        commentBehavior = singleCommentBehavior;
      } else if (openCommentType == ContentType.docComment) {
        tokens = <String>[
          lineCommentEndLong,
          lineCommentEndLong,
          lineCommentEnd
        ];
        commentBehavior = docCommentBehavior;
      } else if (openCommentType == ContentType.blockComment) {
        tokens = <String>[blockCommentEndToken];
        commentBehavior = blockCommentBehavior;
      }
      String chosenToken;
      for (String token in tokens) {
        if (checkToken(token, source, idx)) {
          chosenToken = token;
          openCommentType = null;
          break;
        }
      }
      if (!isCommentOpen()) {
        Comment comment;

        skipCharUpTo = sourceEndPosition(chosenToken);

        if (commentBehavior != CommentBehavior.splitAndLose) {
          if (commentBehavior != CommentBehavior.preserve) {
            comment = _createComment(
                contentType, commentBehavior, chosenToken, startPositionInfo,
                targetContentEnd: startPositionInfo.targetIndex,
                targetPositionEnd: startPositionInfo.targetIndex);
          } else {
            comment = _createComment(
                contentType, commentBehavior, chosenToken, startPositionInfo);
          }
          comments.add(comment);
        }
        startPositionInfo = null;
      }
    } else if (isTextOpen()) {
      if (escapeActive) {
        escapeActive = false;
      } else {
        ContentType contentType;
        List<String> tokens;
        contentType = openTextType;
        if (openTextType == ContentType.singleQuoteText ||
            openTextType == ContentType.rawSingleQuoteText) {
          tokens = <String>[singleQuoteTextEnd];
        } else if (openTextType == ContentType.doubleQuoteText ||
            openTextType == ContentType.rawDoubleQuoeText) {
          tokens = <String>[doubleQuoteTextEnd];
        } else if (openTextType == ContentType.multiLineText ||
            openTextType == ContentType.rawMultiLineText) {
          tokens = <String>[multiLineTextEnd];
        }
        String chosenToken;
        for (String token in tokens) {
          if (checkToken(token, source, idx)) {
            openTextType = null;
            chosenToken = token;
            break;
          }
        }
        if (checkToken(escapeToken, source, idx) &&
            (openTextType == ContentType.singleQuoteText ||
                openTextType == ContentType.doubleQuoteText ||
                openTextType == ContentType.multiLineText)) {
          escapeActive = true;
        }
        if (!isTextOpen()) {
          Content content =
              _createContent(contentType, chosenToken, startPositionInfo);
          skipCharUpTo = sourceEndPosition(chosenToken);

          texts.add(content);

          startPositionInfo = null;
        }
      }
    } else {
      String eatenToken;
      if (checkToken(docCommentToken, source, idx)) {
        openCommentType = ContentType.docComment;
        eatenToken = docCommentToken;
        commentBehavior = docCommentBehavior;
      } else if (checkToken(singleCommentToken, source, idx)) {
        openCommentType = ContentType.singleComment;
        eatenToken = singleCommentToken;
        commentBehavior = singleCommentBehavior;
      } else if (checkToken(blockCommentStartToken, source, idx)) {
        openCommentType = ContentType.blockComment;
        eatenToken = blockCommentStartToken;
        commentBehavior = blockCommentBehavior;
      } else if (checkToken(multiLineText, source, idx)) {
        openTextType = ContentType.multiLineText;
        eatenToken = multiLineText;
      } else if (checkToken(rawMultiLineText, source, idx)) {
        openTextType = ContentType.rawMultiLineText;
        eatenToken = rawMultiLineText;
      } else if (checkToken(singleQuoteText, source, idx)) {
        openTextType = ContentType.singleQuoteText;
        eatenToken = singleQuoteText;
      } else if (checkToken(rawSingleQuoteText, source, idx)) {
        openTextType = ContentType.rawSingleQuoteText;
        eatenToken = rawSingleQuoteText;
      } else if (checkToken(doubleQuoteText, source, idx)) {
        openTextType = ContentType.doubleQuoteText;
        eatenToken = doubleQuoteText;
      } else if (checkToken(rawDoubleQuoteText, source, idx)) {
        openTextType = ContentType.rawDoubleQuoeText;
        eatenToken = rawDoubleQuoteText;
      } else if (checkToken(blockStartToken, source, idx)) {
        PositionInfo startInfo = PositionInfo(
            idx, modifySource ? buffer.length : idx, blockStartToken.length);
        blockLevels.add({startInfo: ContentType.curlyBrackets});
        if (statementLevels.length <= blockLevels.length) {
          for (int idx = statementLevels.length;
              idx <= blockLevels.length;
              idx++) {
            statementLevels.add(null);
          }
        }
        statementLevels[blockLevels.length] = PositionInfo(
            sourceEndContent(), targetEndContent(), blockStartToken.length);
      } else if (checkToken(parenthesesStartToken, source, idx)) {
        PositionInfo startInfo = PositionInfo(idx,
            modifySource ? buffer.length : idx, parenthesesStartToken.length);
        blockLevels.add({startInfo: ContentType.parentheses});
      } else if (checkToken(blockEndToken, source, idx)) {
        int endPosition = modifySource ? buffer.length : idx;
        Map<PositionInfo, ContentType> origin = blockLevels.last;
        if (origin.values.first != ContentType.curlyBrackets) {
          throw StateError('Expected a curly bracket in position $endPosition,'
              'but the open block is of type ${origin.values.first}');
        }
        Content content = _createContent(
            ContentType.curlyBrackets, blockEndToken, origin.keys.first);
        //lastStatement = targetEndPosition(blockEndToken);
        blocks.add(content);
        bool isBlockDefinition = blockLevels.length > 1 &&
            blockLevels[blockLevels.length - 2].values.first ==
                ContentType.parentheses;
        if (isBlockDefinition) {
          _closeStatement(blockEndToken);
        }
        blockLevels.removeLast();
        if (!isBlockDefinition) {
          _closeStatement(blockEndToken, considerCurrentEndToken: true);
        }
      } else if (checkToken(parenthesesEndToken, source, idx)) {
        int endPosition = modifySource ? buffer.length : idx;
        Map<PositionInfo, ContentType> origin = blockLevels.last;
        if (origin.values.first != ContentType.parentheses) {
          throw StateError(
              'Expected a closing parentheses in position $endPosition,'
              'but the open block is of type ${origin.values.first}');
        }
        Content content = _createContent(
            ContentType.parentheses, parenthesesEndToken, origin.keys.first);
        lastStatement = targetEndPosition(parenthesesEndToken);
        blockLevels.removeLast();
        blocks.add(content);
        if (isAnnotationOpen(level: blockLevels.length)) {
          var info = annotationStartPosition.keys.first;

          DartAnnotation annotation = DartAnnotation(
              source.substring(
                  info.sourcePlusToken, sourceEndPosition(parenthesesEndToken)),
              info.sourcePlusToken,
              sourceEndPosition(parenthesesEndToken),
              info.targetIndex,
              info.targetPlusToken,
              targetEndPosition(parenthesesEndToken),
              targetEndPosition(parenthesesEndToken));

          annotations.add(annotation);
          annotationStartPosition = null;
        }
      } else if (checkToken(statementDelimiterToken, source, idx)) {
        _closeStatement(statementDelimiterToken);
      } else if (isDartAnnotation(source, idx)) {
        if (modifySource) {
          annotationStartPosition = {
            PositionInfo(idx, buffer.length, '@'.length): blockLevels.length
          };
/*          print(
 'len = ${buffer.length}, convert ${buffer.toString().length},
 ${buffer.toString().substring(buffer.length - 30)}');*/
        } else {
          annotationStartPosition = {
            PositionInfo(idx, idx, '@'.length): blockLevels.length
          };
        }
      }

      if (isCommentOpen() || isTextOpen()) {
        skipCharUpTo = sourceStartContent(eatenToken); //startContent;
        startPositionInfo = PositionInfo(
            sourceStartPosition(), targetStartPosition(), eatenToken.length);
      }
    }

    if (idx >= skipCharUpTo) {
      skipCharUpTo = idx + 1;
    }
    if (modifySource) {
      for (int i = idx; i < skipCharUpTo; i++) {
        if (commentBehavior == null ||
            commentBehavior == CommentBehavior.preserve) {
          buffer.write(source[i]);
        }
      }
    }
    idx = skipCharUpTo - 1;
  }
  return AnalysisResult(modifySource ? buffer.toString() : source, comments,
      texts, blocks, statements, annotations);
}

/// returns true if the token is verified
bool checkToken(String token, String source, int startIndex) {
  if (startIndex >= source.length ||
      source.length - startIndex < token.length) {
    return false;
  }
  return source.startsWith(token, startIndex);
}

class PositionInfo {
  final int sourceIndex;
  final int targetIndex;
  final int tokenLength;

  PositionInfo(this.sourceIndex, this.targetIndex, this.tokenLength);

  int get sourcePlusToken => sourceIndex + tokenLength;
  int get targetPlusToken => targetIndex + tokenLength;
}
